Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <56EE7E34.8040608@kernel.org>
References: <1458232366-12773-1-git-send-email-daniel.baluta@intel.com>
	<1458232366-12773-2-git-send-email-daniel.baluta@intel.com>
	<CAKzfze-nFeMJhp7oRrKaCuM+CRJpokFevCEdxB1Mu96H+pUT6A@mail.gmail.com>
	<56EE7E34.8040608@kernel.org>
Date: Mon, 21 Mar 2016 12:16:25 +0200
Message-ID: <CAEnQRZCb6qY+XPKyoOjatQ44c65BfGsRo3HU4ozRRMzhx=HXXw@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio: imu: mpu6050: Fix name/chip_id when using ACPI
From: Daniel Baluta <daniel.baluta@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matt Ranostay <mranostay@gmail.com>, Daniel Baluta <daniel.baluta@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Matt Ranostay <matt.ranostay@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>, Crt Mori <cmo@melexis.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Ge Gao <ggao@invensense.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Adriana Reus <adi.reus@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sun, Mar 20, 2016 at 12:40 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 17/03/16 17:21, Matt Ranostay wrote:
>> Reviewed-By: Matt Ranostay <matt.ranostay@intel.com>
> I'm guessing this may at some point want backporting, but right now it only
> applies to my togreg branch (due to prior changes) so that's where I've applied
> this.  If you want a faster path to mainline, the please send me the backport.

Sure. One thing: on which branch should I rebase the changes?

fixes or fixes-togreg?

Daniel.
