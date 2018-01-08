Return-Path: <SRS0=X1ZH=ED=google.com=gwendal@kernel.org>
MIME-Version: 1.0
Sender: gwendal@google.com
In-Reply-To: <369a0027-5ca0-6a4e-3f9a-4f7a498a7cc2@collabora.com>
References: <20180104201718.221900-1-gwendal@chromium.org> <20180104201718.221900-2-gwendal@chromium.org>
 <369a0027-5ca0-6a4e-3f9a-4f7a498a7cc2@collabora.com>
From: Gwendal Grignou <gwendal@chromium.org>
Date: Mon, 8 Jan 2018 09:20:53 -0800
Message-ID: <CAMHSBOW=g=SA4NjP87QLXnrRBxsaMLW1r_w3oyfAvzLq9R5U1g@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio: cros_ec: light code cleanup
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Guenter Roeck <groeck@chromium.org>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Fri, Jan 5, 2018 at 1:22 AM, Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
> Hi Gwendal,
>
> On 04/01/18 21:17, Gwendal Grignou wrote:
>> - use dev instead of &pdev->dev when defined
>> - remove syfs.h inclusion.
>>
>> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
>> ---

>
> This patch looks good to me but did you miss to include the patch when you sent
> v2? At least I did not receive the patch within v2 nor is available in linux-iio
> patchwork v2 series.
I did not resend it as there was not change in this patch between v1
and v2, my mistake. I am resending a newer patch anyway, as the 2
other patches in v2 were incorrect.

Gwendal.
>
> Best regards,
>  Enric
