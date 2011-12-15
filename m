Return-Path: <jic23@hermes.cam.ac.uk>
Date: 15 Dec 2011 10:03:35 +0000
From: "J.I. Cameron" <jic23@cam.ac.uk>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
    "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: buffer enable() and is_enable() callbacks unused?
Message-ID: <Prayer.1.3.4.1112151003350.27344@hermes-2.csi.cam.ac.uk>
In-Reply-To: <4EE9BAE8.8030205@metafoo.de>
References: <4EE9BAE8.8030205@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

On Dec 15 2011, Lars-Peter Clausen wrote:

>Hi,
>
>Currently none of the buffer implementations implements the enable() or
>is_enable() nor does core code try to call these. Is this a left over and
>can be removed or is there a plan to make use of them in the future?

Odd indeed.  No plans to use them from my side anyway.
Must be some left over from an ancient rework.

Feel free to scrap them!

Jonathan
