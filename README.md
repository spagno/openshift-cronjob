# CRONJOB su OpenShift

Per questa POC, e' stato creato un Dockerfile che prende una immagine Alpine Linux (immagine Docker molto piccola), aggiunge uno script.sh usato come CMD che fa un semplicissimo <code>ls</code> prendendo come argomento una variabile di ambiente <code>$ARGS</code>

Le parti importanti da modificare sono:
```name: test-cron-5m``` il nome del cronjob

```name: ARGS``` il nome della variabile utilizzata nello script <code>start.sh</code>
```schedule: '*/5 * * * *'``` la schedulazione del job, esattamente come un qualsiasi sistema linux 

Per piu' dettagli su altre opzioni fare riferimento alla documentazione ufficiale

https://docs.openshift.com/container-platform/3.9/dev_guide/cron_jobs.html

```apiVersion: batch/v1beta1
kind: CronJob
metadata:
  creationTimestamp: null
  name: test-cron-5m
spec:
  concurrencyPolicy: Allow
  failedJobsHistoryLimit: 1
  jobTemplate:
    metadata:
      creationTimestamp: null
    spec:
      template:
        metadata:
          creationTimestamp: null
          labels:
            parent: cronjobtest
        spec:
          containers:
          - env:
            - name: ARGS
              value: -la
            image: docker-registry.default.svc:5000/cron-test/cronjob_test:latest
            imagePullPolicy: IfNotPresent
            name: alpine
            resources: {}
            terminationMessagePath: /dev/termination-log
            terminationMessagePolicy: File
          dnsPolicy: ClusterFirst
          restartPolicy: OnFailure
          schedulerName: default-scheduler
          securityContext: {}
          terminationGracePeriodSeconds: 30
  schedule: '*/5 * * * *'
  successfulJobsHistoryLimit: 3
  suspend: false
status: {}