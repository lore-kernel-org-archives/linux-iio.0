Return-Path: <lars@metafoo.de>
Message-ID: <4EE9BAE8.8030205@metafoo.de>
Date: Thu, 15 Dec 2011 10:16:24 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: buffer enable() and is_enable() callbacks unused?
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Hi,

Currently none of the buffer implementations implements the enable() or
is_enable() nor does core code try to call these. Is this a left over and
can be removed or is there a plan to make use of them in the future?

Thanks
- Lars
