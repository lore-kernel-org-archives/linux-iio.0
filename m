Return-Path: <SRS0=SYmy=DG=users.sourceforge.net=elfring@kernel.org>
Subject: =?UTF-8?Q?Re:_iio/=e2=80=a6:_Use_common_error_handling_code?=
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Hans de Goede <hdegoede@redhat.com>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <5ab7e200-2dea-63e2-06db-0e185f563d16@users.sourceforge.net>
 <0f26a13b-7bbf-525b-a864-8aa8e13c3aef@users.sourceforge.net>
 <20171026174200.5c00b06d@archlinux>
 <e7292cc3-e4e2-0943-7cf9-4852cf37ef36@users.sourceforge.net>
 <20171210160829.16128419@archlinux>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <f8289b08-389a-a6d6-21f6-ca1ba20c2c85@users.sourceforge.net>
Date: Sun, 10 Dec 2017 17:43:34 +0100
MIME-Version: 1.0
In-Reply-To: <20171210160829.16128419@archlinux>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

> Hi Markus, I've accepted the ones that I think made an improvement
> outweighing the inherent small costs of making any change.

Does such a kind of feedback mean that you reconsidered any places
where you expressed a rejection initially?


> We also need to avoid code constructs that are unusual in error handling
> such as backwards gotos.

Why would you like to exclude this approach if anything useful could be achieved
in the shown software design direction?


> Note however that most of the changes made so far are only minor improvements.

I agree that corresponding effects are small just because the discussed
source code adjustments affected specific function implementations.


> I am not saying I don't appreciate them,

Thanks.


> but rather than that they are of of low importance.

A lot of details are competing also for our software development attention.

Regards,
Markus
