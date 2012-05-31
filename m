Return-Path: <ggao@invensense.com>
MIME-Version: 1.0
Date: Thu, 31 May 2012 08:56:43 -0700
Message-ID: <CAE9_fz=THxH8DRwbJMGONJC3szwiJ9DM=NF0HM-e19nqXmtcHQ@mail.gmail.com>
Subject: A IIO trigger problem/bug.
From: Ge Gao <ggao@invensense.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Content-Type: multipart/alternative; boundary=0016e6de00d339211e04c1571d1c
List-ID: <linux-iio@vger.kernel.org>

--0016e6de00d339211e04c1571d1c
Content-Type: text/plain; charset=ISO-8859-1

Dear all,
    I met a strange problem concerning IIO driver. I wrote a driver that
has trigger, ring buffer, just the standard way of doing things. It
sometimes runs OK. However, I found sometimes, the trigger is NOT triggered
at all. I am using a hardware interrupt to trigger a threaded ISR and
post-ISR. I can see the interrupt coming correctly. By using "cat
/proc/interrupts", I can see that the number of triggers stays the same
while the number of interrupt increases steadily.
   I am using "iio_trigger_generic_data_rdy_poll" in the trigger. In the
post ISR, I am using "iio_trigger_notify_done".
I check the IIO trigger code.  The trigger uses "trig->use_count" to do
things. If "trig->use_count" is not zero, nothing will happen. Where the
only place trig->use_count decreases is in "iio_trigger_notify_done". It is
possible that, if system is busy, that post ISR is NOT scheduled, such that
trig->use_count will NOT decrease. This would defeat all the mechanism of
trigger.  Or there are other possibilities that would fail?
   Thanks.

Best regards,

Ge GAO

--0016e6de00d339211e04c1571d1c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p><br>Dear all,<br>=A0=A0=A0 I met a strange problem concerning IIO driver=
. I wrote a driver that has trigger, ring buffer, just the standard way of =
doing things. It sometimes runs OK. However, I found sometimes, the trigger=
 is NOT triggered at all. I am using a hardware interrupt to trigger a thre=
aded ISR and post-ISR. I can see the interrupt coming correctly. By using &=
quot;cat /proc/interrupts&quot;, I can see that the number of triggers stay=
s the same while the number of interrupt increases steadily. <br>
=A0=A0 I am using &quot;iio_trigger_generic_data_rdy_poll&quot; in the trig=
ger. In the post ISR, I am using &quot;iio_trigger_notify_done&quot;. <br>I=
 check the IIO trigger code.=A0 The trigger uses &quot;trig-&gt;use_count&q=
uot; to do things. If &quot;trig-&gt;use_count&quot; is not zero, nothing w=
ill happen. Where the only place trig-&gt;use_count decreases is in &quot;i=
io_trigger_notify_done&quot;. It is possible that, if system is busy, that =
post ISR is NOT scheduled, such that trig-&gt;use_count will NOT decrease. =
This would defeat all the mechanism of trigger.=A0 Or there are other possi=
bilities that would fail?<br>
=A0=A0 Thanks.</p><p>Best regards,</p><p>Ge GAO<br><br></p>

--0016e6de00d339211e04c1571d1c--
