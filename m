Return-Path: <srinivas.pandruvada@linux.intel.com>
Message-ID: <53691420.8060503@linux.intel.com>
Date: Tue, 06 May 2014 09:56:00 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: hardware buffer enabling
Content-Type: multipart/alternative;
 boundary="------------040809020508060608020100"
List-ID: <linux-iio@vger.kernel.org>

This is a multi-part message in MIME format.
--------------040809020508060608020100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jonathan,

The Android user space has some capability to ask the supported hardware 
to enable buffering in hardware.
I don't think that we can achieve this by current ABI.  Do you want me 
to propose new ABI?

"
Android batch mode:
batch(int handle, int flags, int64_t period_ns, int64_t max_report_latency)

Enabling batch mode for a given sensor sets the delay between events. 
max_report_latency sets the maximum time by which events can be delayed 
and batched together before being reported to the applications. A value 
of zero disables batch mode for the given sensor. The period_ns 
parameter is equivalent to calling setDelay() -- this function both 
enables or disables the batch mode AND sets the event's period in 
nanoseconds. See setDelay() for a detailed explanation of the period_ns 
parameter.

In non-batch mode, all sensor events must be reported as soon as they 
are detected. For example, an accelerometer activated at 50Hz will 
trigger interrupts 50 times per second.
While in batch mode, sensor events do not need to be reported as soon as 
they are detected. They can be temporarily stored and reported in 
batches, as long as no event is delayed by more than maxReportingLatency 
nanoseconds. That is, all events since the previous batch are recorded 
and returned at once. This reduces the amount of interrupts sent to the 
SoC and allows the SoC to switch to a lower power mode (idle) while the 
sensor is capturing and batching data.

setDelay() is not affected and it behaves as usual.

Each event has a timestamp associated with it. The timestamp must be 
accurate and correspond to the time at which the event physically happened.

Batching does not modify the behavior of poll(): batches from different 
sensors can be interleaved and split. As usual, all events from the same 
sensor are time-ordered.
"


Thanks,
Srinivas


--------------040809020508060608020100
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <span style="color: rgb(34, 34, 34); font-family: Roboto,
      sans-serif; font-size: 14px; font-style: normal; font-variant:
      normal; font-weight: normal; letter-spacing: normal; line-height:
      19px; orphans: auto; text-align: start; text-indent: 0px;
      text-transform: none; white-space: normal; widows: auto;
      word-spacing: 0px; -webkit-text-stroke-width: 0px;
      background-color: rgb(249, 249, 249); display: inline !important;
      float: none;">Hi Jonathan,<br>
      <br>
      The Android user space has some capability to ask the supported
      hardware to enable buffering in hardware.<br>
      I don't think that we can achieve this by current ABI.&nbsp; Do you
      want me to propose new ABI?<br>
      <br>
      "<br>
      Android batch mode:<br>
      batch(int handle, int flags, int64_t period_ns, int64_t
      max_report_latency)<br>
      <br>
      Enabling batch mode for a given sensor sets the delay between
      events. max_report_latency sets the maximum time by which events
      can be delayed and batched together before being reported to the
      applications. A value of zero disables batch mode for the given
      sensor. The period_ns parameter is equivalent to calling
      setDelay() -- this function both enables or disables the batch
      mode AND sets the event's period in nanoseconds. See setDelay()
      for a detailed explanation of the period_ns parameter.<br>
      <br>
      In non-batch mode, all sensor events must be reported as soon as
      they are detected. For example, an accelerometer activated at 50Hz
      will trigger interrupts 50 times per second.<br>
      While in batch mode, sensor events do not need to be reported as
      soon as they are detected. They can be temporarily stored and
      reported in batches, as long as no event is delayed by more than
      maxReportingLatency nanoseconds. That is, all events since the
      previous batch are recorded and returned at once. This reduces the
      amount of interrupts sent to the SoC and allows the SoC to switch
      to a lower power mode (idle) while the sensor is capturing and
      batching data.<br>
      <br>
      setDelay() is not affected and it behaves as usual.<br>
      <br>
      Each event has a timestamp associated with it. The timestamp must
      be accurate and correspond to the time at which the event
      physically happened.<br>
      <br>
      Batching does not modify the behavior of poll(): batches from
      different sensors can be interleaved and split. As usual, all
      events from the same sensor are time-ordered.<br>
      "<br>
      <br>
      <br>
      Thanks,<br>
      Srinivas<br>
      <br>
    </span>
  </body>
</html>

--------------040809020508060608020100--
