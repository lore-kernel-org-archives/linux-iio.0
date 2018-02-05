Return-Path: <SRS0=6ZMV=E7=users.sourceforge.net=elfring@kernel.org>
Subject: Re: hid-sensor-accel-3d: Delete an error message for a failed memory
 allocation in hid_accel_3d_probe()
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 linux-input@vger.kernel.org
Cc: Hartmut Knaack <knaack.h@gmx.de>, Jiri Kosina <jikos@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <0406765c-bdd1-1a82-cf66-1c248063ae4f@users.sourceforge.net>
 <20180204112346.0977e938@archlinux>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <9420fc82-1a37-3601-bafe-f57ef953bfcd@users.sourceforge.net>
Date: Mon, 5 Feb 2018 19:26:59 +0100
MIME-Version: 1.0
In-Reply-To: <20180204112346.0977e938@archlinux>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

> If making changes like this I would suggest only sending one until
> you have have a response from the relevant maintainer.

The corresponding feedback can become more positive for such
a transformation pattern after a while, can't it?


> It would save you time as often these sorts of changes are
> a matter of personal taste and weighing up of costs vs gains
> - hence it is not obvious that they will be accepted.

Can the wording “WARNING: Possible unnecessary 'out of memory' message”
(from the script “checkpatch.pl”) be another incentive?

Regards,
Markus
