Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <5717A3E6.4010200@metafoo.de>
References: <1461167126-23399-1-git-send-email-daniel.baluta@intel.com>
	<1461167126-23399-4-git-send-email-daniel.baluta@intel.com>
	<5717A3E6.4010200@metafoo.de>
Date: Wed, 20 Apr 2016 18:51:25 +0300
Message-ID: <CAEnQRZAstpFdr8wwNaVacVzwdTZ2M_R-c=mo4gNUHBP67R6cZw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] Documentation: iio: Add IIO software devices docs
From: Daniel Baluta <daniel.baluta@intel.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Daniel Baluta <daniel.baluta@intel.com>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Wed, Apr 20, 2016 at 6:44 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 04/20/2016 05:45 PM, Daniel Baluta wrote:
>
>> +
>> +What:                /config/iio/triggers/dummy
>
> s/triggers/devices

:D, will fix in v2. Obviously, one problem of this RFC is that we
have a lot of duplicate code between the triggers and devices
in configfs support.
