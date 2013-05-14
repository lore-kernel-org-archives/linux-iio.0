Return-Path: <denis.ciocca@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAEE_umrLpNJo1kMbLtktK0RH6WCKCEYR+yiTiyPJu_8G3coE7A@mail.gmail.com>
References: <CAEE_umrLpNJo1kMbLtktK0RH6WCKCEYR+yiTiyPJu_8G3coE7A@mail.gmail.com>
Date: Tue, 14 May 2013 18:18:34 +0200
Message-ID: <CAEE_umq7aC5=HWAW_2N=XsLJ0y6YqBojjN0Awm3BuGmqHSzrsw@mail.gmail.com>
Subject: Use buffer without trigger
From: Denis Ciocca <denis.ciocca@gmail.com>
To: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Content-Type: multipart/alternative; boundary=089e0122e7ee2587ed04dcaffc2b
List-ID: <linux-iio@vger.kernel.org>

--089e0122e7ee2587ed04dcaffc2b
Content-Type: text/plain; charset=ISO-8859-1

Hi all,

I have one question about iio device. I want create with only one physical
device a lot of iio devices because I want to activate each 'sensor'
without stop the buffer and reactivate with more channels.
But, I want to use only one trigger, for example of the major iio device.
It is possible to register only a buffer of one device and use the trigger
of another one?

Thanks
Denis

--089e0122e7ee2587ed04dcaffc2b
Content-Type: text/html; charset=ISO-8859-1

<p dir="ltr">Hi all,</p>
<p dir="ltr">I have one question about iio device. I want create with only one physical device a lot of iio devices because I want to activate each &#39;sensor&#39; without stop the buffer and reactivate with more channels.<br>

But, I want to use only one trigger, for example of the major iio device.<br>
It is possible to register only a buffer of one device and use the trigger of another one?</p>
<p dir="ltr">Thanks<br>
Denis<br>
</p>

--089e0122e7ee2587ed04dcaffc2b--
