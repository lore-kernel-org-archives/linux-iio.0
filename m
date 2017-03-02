Return-Path: <SRS0=1URn=2L=gmail.com=michel.hermier@kernel.org>
Subject: Re: [PATCH 2/2] HID: Remove unnecessary OOM messages
To: Joe Perches <joe@perches.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 =?UTF-8?Q?Bruno_Pr=c3=a9mont?= <bonbons@linux-vserver.org>,
 Stefan Achatz <erazor_de@users.sourceforge.net>,
 Jonathan Cameron <jic23@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <cover.1488395879.git.joe@perches.com>
 <0fbe692283802d36df389af7cbda9a4bff44db5e.1488395879.git.joe@perches.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
From: Michel Hermier <michel.hermier@gmail.com>
Message-ID: <a52260a5-921c-53f9-8709-ae7189395cee@gmail.com>
Date: Thu, 2 Mar 2017 07:51:11 +0100
MIME-Version: 1.0
In-Reply-To: <0fbe692283802d36df389af7cbda9a4bff44db5e.1488395879.git.joe@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Le 01/03/2017 à 20:19, Joe Perches a écrit :
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 70b12f89a193..1ee6aac855a3 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -224,7 +224,6 @@ static int asus_start_multitouch(struct hid_device *hdev)
>   
>   	if (!dmabuf) {
>   		ret = -ENOMEM;
> -		hid_err(hdev, "Asus failed to alloc dma buf: %d\n", ret);
>   		return ret;
>   	}

Trivial set and return value missed.
