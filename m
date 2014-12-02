Return-Path: <richard@nod.at>
From: Richard Weinberger <richard@nod.at>
To: jic23@kernel.org
Cc: harald@ccbib.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	sanjeev_sharma@mentor.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: iio: dht11 Updates
Date: Wed,  3 Dec 2014 00:32:52 +0100
Message-Id: <1417563176-31972-1-git-send-email-richard@nod.at>
List-ID: <linux-iio@vger.kernel.org>

Please see my current patches for your driver.
As discussed in an earlier mail I'm testing with the DHT22 sensor only.
With the IRQ changes I see 84 edges.

I have also a question on your driver. Why you increment
DHT11_DATA_BIT_LOW/timeres by one in the ambiguity check?

        threshold = DHT11_DATA_BIT_HIGH / timeres;
        if (DHT11_DATA_BIT_LOW/timeres + 1 >= threshold)
                pr_err("dht11: WARNING: decoding ambiguous\n");

Thanks,
//richard

[PATCH 1/4] iio: dht11: Add locking
[PATCH 2/4] iio: dht11: IRQ fixes
[PATCH 3/4] iio: dht11: Logging updates
[PATCH 4/4] iio: dht11: Fix out-of-bounds read
