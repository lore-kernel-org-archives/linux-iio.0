Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:32962 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751424AbbGOFN1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 15 Jul 2015 01:13:27 -0400
Received: by widic2 with SMTP id ic2so53444144wid.0
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2015 22:13:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <50E24B24-6DC9-4ECB-8752-B974BD6C53E8@kernel.org>
References: <1436880983-29017-1-git-send-email-gizero@gmail.com>
	<50E24B24-6DC9-4ECB-8752-B974BD6C53E8@kernel.org>
Date: Wed, 15 Jul 2015 07:13:26 +0200
Message-ID: <CAC+thW2XeJESYC-S0BhNk6DFCnsn7HsJp69GAZZvpCL2WGF1+Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] iio: adc: mcp320x: add masking of unknown bits
From: Andrea Galbusera <gizero@gmail.com>
To: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Jul 14, 2015 at 11:04 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>
>
> On 14 July 2015 14:36:20 BST, Andrea Galbusera <gizero@gmail.com> wrote:
>>According to the datasheet, the 2 MSBs for parts 3001 and 3201 are
>>unspecified and should be masked out
> Theoretical issue or one with observed bad effects?

Hi! Thanks for reviewing. While in the business of adding support for
3301, I couldn't figure out why no masking wasn't done for similar
parts like 3001 and 3201. Further investigation of previous patches
reviews [1], where masking was suggested and initially implemented,
convinced me the bit was lost somewhere, with no explicit motivation.
Nevertheless, 3301 is the only chip of the family I have at hands:
hence, yes, this specific patch in the set is addressing a theoretical
issue.

[1] http://marc.info/?l=linux-iio&m=140748835509583&w=2

> Changes the path and timing of this getting applied. Patch itself is fine either way!
>>
>>Signed-off-by: Andrea Galbusera <gizero@gmail.com>
>>---
>>
>>This was already suggested but for some reason got lost during review
>>of a
>>previous patch. See http://marc.info/?l=linux-iio&m=140748835509583&w=2
>>and following discussion
>>
>> drivers/iio/adc/mcp320x.c | 4 ++--
>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>
>>diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
>>index 8d9c9b9..0673ee7 100644
>>--- a/drivers/iio/adc/mcp320x.c
>>+++ b/drivers/iio/adc/mcp320x.c
>>@@ -114,13 +114,13 @@ static int mcp320x_adc_conversion(struct mcp320x
>>*adc, u8 channel,
>>
>>       switch (device_index) {
>>       case mcp3001:
>>-              return (adc->rx_buf[0] << 5 | adc->rx_buf[1] >> 3);
>>+              return ((adc->rx_buf[0] & 0x1f) << 5 | adc->rx_buf[1] >> 3);
>>       case mcp3002:
>>       case mcp3004:
>>       case mcp3008:
>>               return (adc->rx_buf[0] << 2 | adc->rx_buf[1] >> 6);
>>       case mcp3201:
>>-              return (adc->rx_buf[0] << 7 | adc->rx_buf[1] >> 1);
>>+              return ((adc->rx_buf[0] & 0x1f) << 7 | adc->rx_buf[1] >> 1);
>>       case mcp3202:
>>       case mcp3204:
>>       case mcp3208:
>
> --
> Sent from my Android device with K-9 Mail. Please excuse my brevity.
