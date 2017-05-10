Return-Path: <SRS0=jbJW=4Q=metafoo.de=lars@kernel.org>
Subject: Re: [PATCH v2] iio:ad5064: Add support for ltc2633 and similar
 devices
To: Mike Looijmans <mike.looijmans@topic.nl>, linux-iio@vger.kernel.org
References: <1493199875-11912-1-git-send-email-mike.looijmans@topic.nl>
 <646b634f-c0ad-f39c-a395-02461f5e8352@metafoo.de>
 <1494228384-28786-1-git-send-email-mike.looijmans@topic.nl>
Cc: linux-kernel@vger.kernel.org, Michael.Hennerich@analog.com,
 jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <c29df10c-8715-363e-02f4-e3231b65ad51@metafoo.de>
Date: Wed, 10 May 2017 11:12:00 +0200
MIME-Version: 1.0
In-Reply-To: <1494228384-28786-1-git-send-email-mike.looijmans@topic.nl>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 05/08/2017 09:26 AM, Mike Looijmans wrote:
> The Linear Technology LTC2631, LTC2633 and LTC2635 are very similar
> to the AD5064 device, in particular the LTC2627.
> 
> This patch adds support for those devices. Only the LTC2633 has been
> tested, which is the 2-channel variant. The LTC2631 is the 1-channel,
> and the LTC2635 the 4-channel version. The actual DAC resolution depends
> on the exact chip type and can be 12, 10 or 8 bits, using the upper bits
> so this has no effect on the register map. The internal reference is set
> to 2.5V on "L" versions, and it's 4.096V for "H" versions.
> 
> Datasheets:
>     LTC2631: http://www.linear.com/docs/26553
>     LTC2633: http://www.linear.com/docs/39529
>     LTC2635: http://www.linear.com/docs/28754
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks for reworking the patch.
