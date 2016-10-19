Return-Path: <matt@ranostay.consulting>
MIME-Version: 1.0
From: Matt Ranostay <matt@ranostay.consulting>
Date: Wed, 19 Oct 2016 10:13:36 -0700
Message-ID: <CAJ_EiSQ0KEXOqNOQvqcaF5=f-TJtxZNsWs39k6gHuzN_f1OT7w@mail.gmail.com>
Subject: [RFC] multipixel infrared thermopile sensors
To: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Jonathan et all,

Know this has been brought up in the past but what is the view of
multipixel infrared thermopiles?

Initially I plan to do summing average of all the pixels and report
that back, but would like in the future to be able to push the pixel
data to the buffers.

These of course are weird because they barely fit into iio, but nor do
they fit into v4l2 (especially since the data isn't DMA'able).

Datasheet -> https://eewiki.net/download/attachments/13599167/Grid-EYE%20SPECIFICATIONS%28Reference%29.pdf

Thanks,

Matt
