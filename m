Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42228 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754624AbcH2RlZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Aug 2016 13:41:25 -0400
Subject: Re: [PATCH 2/2] iio: gyro: Add driver for the MPU-3050 gyroscope
To: Linus Walleij <linus.walleij@linaro.org>,
        Peter Rosin <peda@axentia.se>
References: <1471286287-25074-1-git-send-email-linus.walleij@linaro.org>
 <53008712-7c50-79db-07ab-3544902887e1@kernel.org>
 <285e7c3f-eedb-28ed-f651-926260d17a8a@axentia.se>
 <CACRpkdZeomin6_u=1hm-fJucMnQmAJXu01YaC0g1KdafWPD2kg@mail.gmail.com>
 <5903e282-aaf9-9c86-5df5-17b75d5b4018@axentia.se>
 <CACRpkdZViewtQgW4GCuOkiKthqZMvXheORmg2rc-xG1cK4S4iA@mail.gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Nick Vaccaro <nvaccaro@google.com>,
        Ge Gao <ggao@invensense.com>, Anna Si <asi@invensense.com>,
        Nathan Royer <nroyer@invensense.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Crestez Dan Leonard <leonard.crestez@intel.com>,
        Daniel Baluta <daniel.baluta@intel.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <4735c01a-0818-4d59-f9ec-4d77812ac905@kernel.org>
Date: Mon, 29 Aug 2016 18:41:22 +0100
MIME-Version: 1.0
In-Reply-To: <CACRpkdZViewtQgW4GCuOkiKthqZMvXheORmg2rc-xG1cK4S4iA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 26/08/16 08:39, Linus Walleij wrote:
> On Thu, Aug 25, 2016 at 10:32 PM, Peter Rosin <peda@axentia.se> wrote:
>> On 2016-08-25 14:44, Linus Walleij wrote:
> 
>>> Then the rest is merge mechanics, dunno the best there,
>>> Jonathan can decide.
>>
>> I waited a bit for someone to scream about v4.8-rc3 being a bad base
>> for some reason, but there was only silence. I have now pushed the
>> series, and it can be pulled by anyone interested.
>>
>> Wolfram, please merge it into i2c/for-next
>>
>> Linus/Jonathan, technically you don't need all patches and can skip
>> the last three, but it seems a bit over the top to be super anal
>> about that detail...
> 
> OK I'll pull this into my development branch. At least we can
> merge the bindings, whether to merge the driver this or next merge
> window (or simply apply the patch to the I2C tree!) is another issue.
> 
> Yours,
> Linus Walleij
When you post future versions Linus, please include a mention of 
the dependency and a link to Peter's tree.

Peter, please can keep that branch around for now.

If we get this sorted in time to be prior to the next merge window
I'll pull your tree into IIO as well as Wolfram having already
pulled it into i2c.  Both will work there way upstream and
all will be fine.  My pull request tag will simply have a description
of why we are doing this.

Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

