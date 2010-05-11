Return-Path: <21cnbao@gmail.com>
MIME-Version: 1.0
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 11 May 2010 15:59:06 +0800
Message-ID: <AANLkTinVNqGBQqVaitQHwxmh_EVzkNhLNpl1Fzyc0eTC@mail.gmail.com>
Subject: adis16220 capture event
To: jic23@cam.ac.uk
Cc: linux-iio@vger.kernel.org
Content-Type: multipart/alternative; boundary=001636284928993ae704864ce7b8
List-ID: <linux-iio@vger.kernel.org>

--001636284928993ae704864ce7b8
Content-Type: text/plain; charset=UTF-8

Jonathan,
adis16260 in drivers/staging/iio/gyro/ has been ready too.
Do you have time to take a look at the datasheet of adis16220? I think it is
much different. The chip has no register to show the current sample value.
It only has a capture buffer mode.  For every capture(by manual or by period
at least 1 second), the ADIS16220 produces and stores 1024
samples of acceleration and analog input channel data into the capture
buffers. It has no a fixed frequency to sample, by depends on user commands
or timer to trigger a capture.
I think current iio doesn't support it at all:
1. sysfs node is useless to show current value
2. it doesn't sample periodically, so ring is useless too.
Its work flow is:
capture -> 1024 data -> capture -> 1024 data -> capture -> 1024 data ....
I want to add a binary sysfs node for capture buffer. Every time, users
begin a capture, after finishing, read 1024 data from the binary node.

Do you have any idea?

Thanks
Barry

--001636284928993ae704864ce7b8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Jonathan,<br>adis16260 in drivers/staging/iio/gyro/ has been ready too.<br>=
Do you have time to take a look at the datasheet of adis16220? I think it i=
s much different. The chip has no register to show the current sample value=
. It only has a capture buffer mode.=C2=A0 For every capture(by manual or b=
y period at least 1 second), the ADIS16220 produces and stores 1024<br>

samples of acceleration and analog input channel data into the capture buff=
ers. It has no a fixed frequency to sample, by depends on user commands or =
timer to trigger a capture.<br>I think current iio doesn&#39;t support it a=
t all:<br>

1. sysfs node is useless to show current value<br>2. it doesn&#39;t sample =
periodically, so ring is useless too.<br>Its work flow is:<br>capture -&gt;=
 1024 data -&gt; capture -&gt; 1024 data -&gt; capture -&gt; 1024 data ....=
<br>

I want to add a binary sysfs node for capture buffer. Every time, users beg=
in a capture, after finishing, read 1024 data from the binary node.<br><br>=
Do you have any idea?<br><br>Thanks<br>Barry<br>

--001636284928993ae704864ce7b8--
