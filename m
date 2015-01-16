Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <1421372464-30316-1-git-send-email-ktsai@capellamicro.com>
References: <1421372464-30316-1-git-send-email-ktsai@capellamicro.com>
Date: Fri, 16 Jan 2015 12:09:14 +0200
Message-ID: <CAEnQRZAmUAchC_EYxhaJ3ayC4+=sDJA0WDtQqbg8YhZV-rErHw@mail.gmail.com>
Subject: Re: [PATCH V3 1/1] iio: Added Capella cm3232 ambient light sensor driver.
From: Daniel Baluta <daniel.baluta@intel.com>
To: Kevin Tsai <ktsai@capellamicro.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>,
	Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, Grant Likely <grant.likely@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joe Perches <joe@perches.com>,
	Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Antti Palosaari <crope@iki.fi>,
	Daniel Baluta <daniel.baluta@intel.com>, Archana Patni <archana.patni@linux.intel.com>,
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Fri, Jan 16, 2015 at 3:41 AM, Kevin Tsai <ktsai@capellamicro.com> wrote:
> CM3232 is an advanced ambient light sensor with I2C protocol interface.
> The I2C slave address is internally hardwired as 0x10 (7-bit).  Writing
> to configure register is byte mode, but reading ALS register requests to
> use word mode for 16-bit resolution.

IIO part looks good to me. Would be nice to see some comments from
Peter and Hartmut.


thanks,
Daniel.
