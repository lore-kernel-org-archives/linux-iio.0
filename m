Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795656733;
	b=p1jJtITY+s6Ot3lTXULyNeLpSP6YPf4jKI+uETqhvQEq7mBxD/bNwgOoRdufvSc4Y+eS
	 1z08YovVc1L/Qxfymv4QeiUAlYLU3iPUaqHCq/cZ/FIOPhXthQ2YvXNocZiZ9p2NoYkd/
	 gHwazvVNZF1AQY/4B4D/8seTPJNQ/DyDI6Ch+UGBSU/xmwT5wA4zYxQZNS2vTkWycNG43
	 /ycn6yyNIUUNokim5PlJhG1hSlFxIi8iqhZGX9Cnr7XF3iiq81c3Y5yzcemqV03BW/fkt
	 ZI6nWK8NSEOfAQHN330h7QF0zqVZwdf1WArnR+eC9+mTReMRMKuiGFVvcUQhyifsaNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795656733;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Eog6deV4YB5f+G+OrMJAOPYxDFumDpt5utWJQYgUWXo=;
	b=0ECn1y6oA+jTrAEtqUzAUEkcn+2giBNtL2KKJFjY0WchIbrXtHoT2CdP0ZPtrfsGZkP5
	 bJdqHBcjjsJfzp75tTxF2UYYnza1c1C+Wuoz5djxZI7yrqAIDH39aU++D0t56D9SfCXTl
	 6vN/fFDWloImbMijDXmiq5Psxrhi5Tz2ZheZGCWHmo9VYuGNXd6X+jqwhz6M3YKyZzMjt
	 AvGII7PEGzCcTuC3vw0So+fOeoPaxFZa+Mz8dKynD4I+g5Caj0Lk7yRPJWsbNH6XqQxYv
	 lM5rDfGMZ5Qv49JDWHmgRut/CoY/7IEduPCRu7D3LSIDYW50DRmHbGrUI4xUEMqprWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UBWUCUgG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEED5606A321;
	Thu, 26 Nov 2026 01:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UBWUCUgG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D561F000C0;
	Thu, 26 Nov 2026 01:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795656733;
	bh=Eog6deV4YB5f+G+OrMJAOPYxDFumDpt5utWJQYgUWXo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UBWUCUgGvpili1xW8TEc9StLz9Uzh82qAIbKwv4VOktCyu+3/Kul7dJGppOuzZ4cK
	 wAAFfDRf4jgnb2J8GVCE3uw/7ugbljitdp1+KKyiJdAGxhnCSPNvaR/1O724+gXVts
	 /108BPO7K6WsFFMBddJFryOxLjZdR1vU5Xe/oXjM+hwl++M0UY5pUQURDPMeddvwIO
	 6WXzCKq5hLQnN5ublimvl1CHpoqiS5Us9piuos0Q/xiOvpPeubT5VQb28f96Vz37+o
	 2uMqOo4WJyt5R3t+azshPbF0kY8Q+f9teG70fMo/8ZsC8B8niSV45VlqsdpPzVJv/3
	 WX2qsIVYR4cDw==
Date: Thu, 26 Nov 2026 01:32:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Joshua Crofts <crofts@kernel.org>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Nishant Malpani <nish.malpani25@gmail.com>, linux@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] iio: gyro: adis16130: apply iwyu principle
Message-ID: <20261126013205.1142d9a7@jic23-hlaptop>
In-Reply-To: <awdZuWcPTXQ35SMX@ashevche-desk.local>
References: <20261125-gyro-kernel-header-removal-v1-0-969b3e668d35@kernel.org>
	<20261125-gyro-kernel-header-removal-v1-4-969b3e668d35@kernel.org>
	<awdZuWcPTXQ35SMX@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Nov 2026 23:57:13 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Nov 25, 2026 at 08:24:05PM +0100, Joshua Crofts wrote:
> > Remove the catch all kernel.h header and add/remove the remaining
> > headers in accordance with the IWYU principle.  
> 
> ...
> 
> > -#include <linux/kernel.h>
> >  #include <linux/spi/spi.h>
> > -#include <linux/module.h>  
> 
> > -  
> 
> Leave this blank line before iio/ group as it originally was.

Tweaked and also removed the extra line we end up with at the end
as a result of moving unaligned.h

> 
> > +#include <linux/unaligned.h>
> > +#include <linux/types.h>
> >  #include <linux/iio/iio.h>
> >  
> > -#include <linux/unaligned.h>  
> 

