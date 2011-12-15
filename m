Return-Path: <lars@metafoo.de>
Message-ID: <4EE9E86D.9020002@metafoo.de>
Date: Thu, 15 Dec 2011 13:30:37 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: How should we deal with multiple concurrent user of the chrdev file?
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Hi,

Currently it is possible to open the iio device chrdev file multiple times.
Since we only support one reader for the buffer at a time this can cause
problems. There is a busy flag for the buffer, which is cleared when the
buffer is released. But the flag is never set and never tested. I suppose
this is a left over from the merge of the event and buffer chrdevs into one.
Events btw. still implement the busy logic and you can only get one event
file descriptor at a time.

Should we add a per iio device busy flag which only allows one open file
descriptor of the iio device chrdev at a time? This has the downside that it
will no longer be possible for one application to listen to the events of
the device and for another application to read from the buffer. But I
suppose the use-case for this is rather limited anyway.

- Lars
