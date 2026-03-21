Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071002C0261;
	Sat, 21 Mar 2026 20:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774126615; cv=none; b=hKviJy3WS2fQ5zkazFqi4GgjdFEa64yUNsBp85kIB7PdYECxNPo1NCj6o7oMqOe00NAbw8dyHKumSKcfR+m7XGY6wH6TPIjd2FMpS5aUPQwYp0/+8tkdPpAsvUJJsov66+aUBnut9WWp/tTPF8iASFlcq1XlOSwStfqNOz5rNAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774126615; c=relaxed/simple;
	bh=hyYA6vl0zbd9LwE4a3NTgJmtV3tB6zYBRgFT/gPsJPY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bdEIGakMtwJ06I4Jhl7qDM7b0NOBlWT9wpZdePETy8WO0eeGJTByxSiMTryCeWHQ3S57OtgG7il0C7PAxHEW/X/uRH0HnSXb/IIlykGqBGEOzIuTKtKxYeonRO5r/xYUCkYwzXEW+CVGzCU4qY/PsmhF3yLheT4H8Ce9RwjocTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1cpxwvh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1cpxwvh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04FC1C19421;
	Sat, 21 Mar 2026 20:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774126614;
	bh=hyYA6vl0zbd9LwE4a3NTgJmtV3tB6zYBRgFT/gPsJPY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h1cpxwvh+lMvjO8iJ0BYWyA4gomsGtBL0uQdKNgbyyF63l3Gke+jI5Pkp/WiNkvKU
	 dJy9wdDzwtcivy4tVhmPMT3m4h0FZZ7aGpcnNl3HFhtUZizjIw2aBenGLvC92a23YA
	 85vF19Gjzxf/2ULU9sKCnnDoaeVNdxA7gtjQAalEtPw0bVDa7JTIMvzPcxINT2P6qe
	 Qv9Du81u3An9gfP3Chdx4Pl6wvdl2pobCq2ir/2+tSvhXqw53uCP2hvo4UXj7YZ2FR
	 40Bapep0gOMU45K4nrYWRwEmDv68m+7dyt29x7PxLX5YKjslDAoE2r0Okhbyr3FacM
	 8GyaCwHDy00ZA==
Date: Sat, 21 Mar 2026 20:56:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: health: max30100: drop unnecessary cast
Message-ID: <20260321205646.207ac77f@jic23-huawei>
In-Reply-To: <abfojPjXKhI6V9e-@ashevche-desk.local>
References: <20260314-iio-health-max301000-drop-int-cast-v1-1-ed4982d559f5@baylibre.com>
	<abfojPjXKhI6V9e-@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Mar 2026 13:25:00 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sat, Mar 14, 2026 at 05:33:01PM -0500, David Lechner wrote:
> > Drop an unnecessary cast in max30100_led_init().
> > 
> > val is defined as unsigned int val[2]; so the cast is not needed, nor
> > is the address-of operator &.
> > 
> > Also fix alignment with ( while we are touching this.  
> 
> >  	ret = device_property_read_u32_array(dev, "maxim,led-current-microamp",
> > -					(unsigned int *) &val, 2);
> > +					     val, 2);  
> 
> You want to have ARRAY_SIZE() as well.
> 
Should we make val a u32 val[2]?

Obviously we all know the unsigned int is that big, but in theory that might
not always be so...

This is the only place where it's passed as a pointer rather than value from
one of the elements I think.


