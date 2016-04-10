Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43968 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753060AbcDJNvj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 10 Apr 2016 09:51:39 -0400
Subject: Re: [PATCH 5/9] iio: accel: mma7455: use regmap to retrieve struct
 device
To: Joachim Eastwood <manabian@gmail.com>,
	Alison Schofield <amsfield22@gmail.com>
References: <cover.1459918214.git.amsfield22@gmail.com>
 <acaeee6c3c1f99900614baf99ab31e6e5b515970.1459918214.git.amsfield22@gmail.com>
 <CAGhQ9VxnwX6n6PfOFAhYSPfP7eAA+YFLjTcJf+Ay60R8sHV_Ww@mail.gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Kukjin Kim <kgene@kernel.org>,
	=?UTF-8?Q?Krzysztof_Koz=c5=82owski?= <k.kozlowski@samsung.com>,
	linux-iio@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	linux-samsung-soc@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <570A5A66.4020901@kernel.org>
Date: Sun, 10 Apr 2016 14:51:34 +0100
MIME-Version: 1.0
In-Reply-To: <CAGhQ9VxnwX6n6PfOFAhYSPfP7eAA+YFLjTcJf+Ay60R8sHV_Ww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/04/16 08:35, Joachim Eastwood wrote:
> Hi Alison,
> 
> On 6 April 2016 at 07:18, Alison Schofield <amsfield22@gmail.com> wrote:
>> Driver includes struct regmap and struct device in its global data.
>> Remove the struct device and use regmap API to retrieve device info.
>>
>> Patch created using Coccinelle plus manual edits.
>>
>> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
>> ---
>>  drivers/iio/accel/mma7455_core.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iio/accel/mma7455_core.c b/drivers/iio/accel/mma7455_core.c
>> index c633cc2..c902f54 100644
>> --- a/drivers/iio/accel/mma7455_core.c
>> +++ b/drivers/iio/accel/mma7455_core.c
>> @@ -55,11 +55,11 @@
>>
>>  struct mma7455_data {
>>         struct regmap *regmap;
>> -       struct device *dev;
>>  };
>>
>>  static int mma7455_drdy(struct mma7455_data *mma7455)
>>  {
>> +       struct device *dev = regmap_get_device(mma7455->regmap);
> 
> ah, nice!
> 
> Acked-by: Joachim Eastwood <manabian@gmail.com>
Applied to the togreg  branch of iio.git - initially pushed out as testing
for the autobuilders to play with it.

This one is a fairly standard case and can be easily chased through to
see that the device pointer is the same one either way.

I'm going to let the rest sit a little longer to see if we get more
feedback on them

Jonathan
> 
> 
> regards,
> Joachim Eastwood
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

