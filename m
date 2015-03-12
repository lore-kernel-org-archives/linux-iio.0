Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <CAEnQRZAK-aLWvcgMrJy0+xiHFAX+2kGgy4nek+q_OtqCmkrwPQ@mail.gmail.com>
References: <20150312145536.GA20026@haneen-vb>
	<CAEnQRZAK-aLWvcgMrJy0+xiHFAX+2kGgy4nek+q_OtqCmkrwPQ@mail.gmail.com>
Date: Thu, 12 Mar 2015 17:09:15 +0200
Message-ID: <CAEnQRZA=4DfNUNPL3YH0C70PUe9OYdymoy2wB76=qygjwmjLgw@mail.gmail.com>
Subject: Re: [Outreachy kernel] [PATCH] iio: Add ABI documentation for
 proximity scan_emlements
From: Daniel Baluta <daniel.baluta@intel.com>
To: Daniel Baluta <daniel.baluta@intel.com>, Haneen Mohammed <hamohammed.sa@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	outreachy-kernel@googlegroups.com,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Thu, Mar 12, 2015 at 5:06 PM, Daniel Baluta <daniel.baluta@intel.com> wrote:
> On Thu, Mar 12, 2015 at 4:55 PM, Haneen Mohammed
> <hamohammed.sa@gmail.com> wrote:
>> This patch adds ABI documentation entries for in_proximity_en,
>> in_proximity_type, and in_proximity_index in the scan_elements.
>> At lease one user for these is present, the AS3935 Franklin lightning sensor.
>>
>> Signed-off-by: Haneen Mohammed <hamohammed.sa@gmail.com>
>
> Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>
>
> I know that Greg won't accept patches outside of drivers/staging/. I
> think this should go via linux-iio tree.
>
> Thanks Haneen!

One thing. There is a typo in the commit subject:

s/scan_emlements/scan_elements.

Could you resend? Please keep Jonathan, Greg and linux-iio mailing list in Cc.

thanks,
Daniel.
