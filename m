Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41838 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798AbbIERHg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Sep 2015 13:07:36 -0400
Subject: Re: [PATCH 6/6] iio: mma8452: leave sysfs namings to the iio core
To: Martin Kepplinger <martink@posteo.de>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, mfuzzey@parkeon.com,
	roberta.dobrescu@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org
References: <1441107913-4112-1-git-send-email-martink@posteo.de>
 <1441107913-4112-7-git-send-email-martink@posteo.de>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	christoph.muellner@theobroma-systems.com,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55EB2155.7050305@kernel.org>
Date: Sat, 5 Sep 2015 18:07:33 +0100
MIME-Version: 1.0
In-Reply-To: <1441107913-4112-7-git-send-email-martink@posteo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/09/15 12:45, Martin Kepplinger wrote:
> This doesn't actually change anything since the core names the sysfs folder
> for the iio event attributes "events" anyways. It only leaves the job to the
> core.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Good point.  I wonder if we have others of these in the tree.

Anyhow, an excellent patch set.  As I've said, I'll pick them up in
perhaps a week if Peter or someone else hasn't intervened in the meantime.

Give me a poke if I don't seem to be doing so!

Jonathan
> ---
>  drivers/iio/accel/mma8452.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 15d50c9..1eccc2d 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -772,7 +772,6 @@ static struct attribute *mma8452_event_attributes[] = {
>  
>  static struct attribute_group mma8452_event_attribute_group = {
>  	.attrs = mma8452_event_attributes,
> -	.name = "events",
>  };
>  
>  #define MMA8452_CHANNEL(axis, idx, bits) { \
> 

