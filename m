Return-Path: <axel.lin@ingics.com>
Message-ID: <1440996094.1500.1.camel@ingics.com>
Subject: IIO: ak8975: Why adding OF compatible string without vendor prefix?
From: Axel Lin <axel.lin@ingics.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen
	 <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>, Laxman Dewangan
	 <ldewangan@nvidia.com>, Olof Johansson <olof@lixom.net>
Date: Mon, 31 Aug 2015 12:41:34 +0800
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hi,
I just found the ak8975_of_match table has compatible string without vendor
prefix.

static const struct of_device_id ak8975_of_match[] = {
        { .compatible = "asahi-kasei,ak8975", },
        { .compatible = "ak8975", },
        { .compatible = "asahi-kasei,ak8963", },
        { .compatible = "ak8963", },
        { .compatible = "asahi-kasei,ak09911", },
        { .compatible = "ak09911", },
        { .compatible = "asahi-kasei,ak09912", },
        { .compatible = "ak09912", },
        {}
};

This seems unusual, just curious why below compatible strings are required?
        { .compatible = "ak8975", },
        { .compatible = "ak8963", },
        { .compatible = "ak09911", },
        { .compatible = "ak09912", },

Regards,
Axel
