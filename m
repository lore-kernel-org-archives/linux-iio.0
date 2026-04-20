Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D90D3A0E9A;
	Mon, 20 Apr 2026 18:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776708109; cv=none; b=UrJ5aQ37M/a24E3AzUSZkoFXFoHT/BeK7zVGBtjsNpMiBJEVkVlhKTlUYGggTIk/WGSmAKbt34FG0fXfqYpZF8Dtk/cRj/2SXgyQ1cglxJZB3yzQQcGUed9Zo+E2QuDIS1oqOJBlWePWdSRz16oT2I1e64mL8HHIULK0wxpJI/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776708109; c=relaxed/simple;
	bh=5ZOBj2MSfadqjAlNaI7TAzdRXrp3vqbSeTQUJ7kkoYs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jTTogQl84VFLPxL0sY9270G6xeawltYKcLLXzVSotIU27DEjQ8lPTaZBbd5sIWWOGWsqQ1RGTEcuPG3P6YQFCybvC/B7/jHhXkpmnOXs1bwD8ETnNKj7oSt2ofONVx640FlNUhuDn++0TLJhfg2s3xpafu3SZ68dB5/dBjbbXfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbfIs14D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbfIs14D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA493C19425;
	Mon, 20 Apr 2026 18:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776708108;
	bh=5ZOBj2MSfadqjAlNaI7TAzdRXrp3vqbSeTQUJ7kkoYs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kbfIs14Duo4FZYd6HfO3OSuPn9o0zu1yh9e9iUuJbKhylchg1IXOSv8r3MQeSk3+8
	 JwTd8IkUkfdm+om7dU/ObltOE7L4mMYUS3GKuCKvmiBxEcumJv/nXo9jgYYP/jRWAh
	 gVjElQmeAe8coIOmGRMjkHoIVM/gIiR9AegmlV/nDOKqZxLUoJEE6471ZjfjXemZcE
	 +scs6Kr1pHTJK7KR4BjyPeqfxPAq9uNxwjeacQxglxaoQN0T0ejVgia7exredcXpfm
	 mQsN8vxdqygbziqt+3SyrATy4E2+MpI9kV+nKWXS313bYKnT4tpCu5lWiefuNC8mcn
	 IHHeO92efBTWw==
Date: Mon, 20 Apr 2026 19:01:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Guilherme Ivo Bozi <guilherme.bozi@usp.br>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad4170: use lookup table for gpio mask
 selection
Message-ID: <20260420190139.37377770@jic23-huawei>
In-Reply-To: <adQOnSHRS3baSTLv@ashevche-desk.local>
References: <20260405213725.25426-2-guilherme.bozi@usp.br>
	<adQOnSHRS3baSTLv@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 Apr 2026 22:50:53 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sun, Apr 05, 2026 at 06:37:26PM -0300, Guilherme Ivo Bozi wrote:
> > Both ad4170_gpio_direction_input() and
> > ad4170_gpio_direction_output() duplicate the same switch
> > statement to map a GPIO offset to its corresponding mask.
> > 
> > Replace the switch with a static lookup table, simplifying the code
> > and avoiding duplication. This also makes future extensions easier.
> > 
> > No functional change intended.  
> 
> If this churn is okay by maintainers,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
Applied.

Thanks,

J

