Return-Path: <SRS0=9PaP=AO=perches.com=joe@kernel.org>
Message-ID: <1505339903.8969.20.camel@perches.com>
Subject: Re: [PATCH v2 1/2] include: linux: sysfs: Add __ATTR_NAMED macro
From: Joe Perches <joe@perches.com>
To: Dan Carpenter <dan.carpenter@oracle.com>, Greg KH
	 <gregkh@linuxfoundation.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, devel@driverdev.osuosl.org,
 daniel.baluta@gmail.com, Himanshi Jain <himshijain.hj@gmail.com>,
 Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, nick.desaulniers@gmail.com,
 outreachy-kernel@googlegroups.com, pmeerw@pmeerw.net, knaack.h@gmx.de,
 Jonathan Cameron <jic23@kernel.org>
Date: Wed, 13 Sep 2017 14:58:23 -0700
In-Reply-To: <20170913214333.mcw4f24fkzndwh5k@mwanda>
References: <cover.1505291907.git.himshijain.hj@gmail.com>
	 <2bc7a124ab925dd2c50aa8c778745d179777d50d.1505291907.git.himshijain.hj@gmail.com>
	 <20170913180310.27cbf1b1@archlinux> <20170913185805.GB26390@kroah.com>
	 <5e43ea4d-eab8-c4be-c5dc-2f862578d011@metafoo.de>
	 <20170913212952.GD9288@kroah.com> <20170913214333.mcw4f24fkzndwh5k@mwanda>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Thu, 2017-09-14 at 00:43 +0300, Dan Carpenter wrote:
> He was exagerating a bit to call it a "static checker" warning...

Not really.

False positives and false negatives exist in just about
every static
checker.

> It's just checkpatch.pl complaining about adding spaces around the -
> operator.

checkpatch is a brain-damaged by design static checker.
regexes can only be sensitive to patterns, not compiled code.

> The sysfs file has a hyphen in the middle.

Another option would be to use an underscore instead.
