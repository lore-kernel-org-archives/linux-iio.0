Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B48D30BF70;
	Mon, 21 Sep 2026 02:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789956657; cv=none; b=V2m6lvKR4ewlmIKLe0YGs36dGKUs8vpG36VZDU5I/cf5u9GoPiCbfGf/6PSreiYq/oJMLktZCu4awAXzAAufrCTsTZ+145+eUcHSTo24R6vKL4JeZ76Mo0ZUc7HZP+FsUWFokGXVAynHf4bIWJktqAgCMJ20qZHI7UfG/m3aeb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789956657; c=relaxed/simple;
	bh=aUDACwDStVzjM+F2npJ/h4BbQFznP8OS1TGbxbv8WpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QDugc8q8i934roUlyOSpS0wcVK56a1OQ/X8X9gQu0ujTiCU0yEPxqHopzQ474f5sSID0BxvZcD106M4xUG/ZtP6qc9zfKHH/tmnz58CT9AaTaxZCgReI2kO7FdCgxU00BAW8+iRZd6LyYijQf1hBTfHa8X4VT0SRK5YmZWACjQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6n1bYa6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6n1bYa6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4321F000FF;
	Mon, 21 Sep 2026 02:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789956655;
	bh=NhImPibtvOUZtnLDZAHZuztyyY5AGDMx8uSdsrXfV7o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=O6n1bYa61Vz6wp2GKO3rtaEQUkAJTf9boUeUTjExGcSOyZStLAyiGi3MN38VMkqiL
	 iGi1jOUdjMXJMEJhIQXCaR33/XVlBKTo2/H0KWDU+U9x3V+QfBr2q/iZB/lN4UNXKJ
	 kr97nmL3itfVF0fJh6sCc0cOMnNgirJjmMkx7r6xZ85bIYm3bXb0YPhhCCYnV+Hr1U
	 PEdUAuwUxYmB5y1TXcIhihMD+KslgU0C3LDHBsSnVVCL2nFvp5t8y0rHBFWO20BoGc
	 SdsYhJrGWlD9Ldu43GjHWLUR7sOcJfDTqhSHm7oYSOl2uRpuCszEybRhYD5lm6D82t
	 yAN1JtSrcT2ag==
Date: Mon, 21 Sep 2026 03:10:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc: Tsz Shan Chan <tsz.chan.dev@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Tsz Shan Chan <tchan@jacques.com.au>
Subject: Re: [PATCH v3] iio: light: apds9306: fix default sampling frequency
 definition
Message-ID: <20260921031050.2ee15633@jic23-hlaptop>
In-Reply-To: <56f77aaf-30ca-451d-b3f4-8a80f3be1c6a@tweaklogic.com>
References: <20260904-apds9306-v3-1-4f668393c2ae@jacques.com.au>
	<20260906045929.0a1c46fd@jic23-huawei>
	<56f77aaf-30ca-451d-b3f4-8a80f3be1c6a@tweaklogic.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Sep 2026 20:29:36 +0930
Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:

> On 6/9/26 1:29 pm, Jonathan Cameron wrote:
> > On Fri, 04 Sep 2026 11:19:48 +1000
> > Tsz Shan Chan <tsz.chan.dev@gmail.com> wrote:
> >   
> >> APDS9306_SAMP_FREQ_10HZ is defined as 0.
> >>
> >> According to the datasheet (Broadcom AV02-4755EN, page 11,
> >> ALS_MEAS_RATE), bits[2:0] set the measurement rate:
> >> - 000: 25ms  (40Hz)
> >> - 001: 20ms  (20Hz)
> >> - 010: 100ms (10Hz)
> >>
> >> Change APDS9306_SAMP_FREQ_10HZ from 0 to 2 to write the correct value
> >> for 10Hz.
> >>
> >> Datasheet: https://docs.broadcom.com/doc/AV02-4755EN
> >> Fixes: 620d1e6c7a3f ("iio: light: Add support for APDS9306 Light Sensor")
> >> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> >> Signed-off-by: Tsz Shan Chan <tchan@jacques.com.au>  
> > Looks correct to me, but as driver is only a few years old, I'll leave
> > some time to see if Subhajit is still about to take a look.
> > 
> > Jonathan  
> 
> Hi Tsz,
> Really good find.
> I am just trying to find out how this happened as this is not a logic or implementation error!
> Let me rig up my test setup, read back from the reg and make sure it gives 0x22 without any init.
> 
> Looks all right to me according to the datasheet and init sequence.
> Acked-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
> 
Shout if your testing shows up anything interesting.
In meantime I've queued this up on the testing branch of iio.git and marked
it for stable

Thanks,

Jonathan

> Thanks Andy and Jonathan.
> 
> Regards,
> Subhajit Ghosh
> 
> >> ---
> >> Changes in v3:
> >> - Move datasheet URL to datasheet tag in the commit message
> >> - Link to v2: https://lore.kernel.org/r/20260903-apds9306-v2-1-e8673986ae56@jacques.com.au
> >>
> >> Changes in v2:
> >> - Add datasheet link to commit message
> >> - Remove blank line in the tag block
> >> - Link to v1: https://lore.kernel.org/r/20260903-apds9306-v1-1-3f892aa4f156@jacques.com.au
> >> ---
> >>   drivers/iio/light/apds9306.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
> >> index f681b02e4922..7dd41136734f 100644
> >> --- a/drivers/iio/light/apds9306.c
> >> +++ b/drivers/iio/light/apds9306.c
> >> @@ -61,7 +61,7 @@
> >>   #define APDS9306_NUM_REPEAT_RATES	7
> >>   #define APDS9306_INT_SRC_CLEAR	0
> >>   #define APDS9306_INT_SRC_ALS	1
> >> -#define APDS9306_SAMP_FREQ_10HZ	0
> >> +#define APDS9306_SAMP_FREQ_10HZ	2
> >>   
> >>   /**
> >>    * struct part_id_gts_multiplier - Part no. and corresponding gts multiplier
> >>
> >> ---
> >> base-commit: 940de590b839f71d6dc846160534bf202401b8b7
> >> change-id: 20260903-apds9306-bedba7b74e59
> >>
> >> Best regards,  
> >   
> 

