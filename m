Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41AE40B108;
	Wed, 12 Aug 2026 11:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786535030; cv=none; b=kkRPJL16eLQwXazO9/2BReNWBsjyAqMrYtI2jBr+L41XyPfiRUUzVVGxSLarHLP2di12Vv3c79Nqi0yo+O9QLvrgzDFluFVlOjbA7oohenr5ldurZdItnwU2X9phGUq8zzNwQ1LeQVqCaeKs/rLsx7wl/xsDD0Clyw7NSZPPO7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786535030; c=relaxed/simple;
	bh=hjekVHmV5srSlPUV+cmDzCU6AJUd4zvQcmdsQ1V5S/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDPUr6fFdp6sFJsmeoCm5qtHfubors6srG8SbLSa6rjH5Btn9aSiiCOavTyyis4gVJxE3N4m+X81+Pl/1V1siD8rM4T5/XXu2YzSJ/7Ek+dHhjb1a095rU41zJoGON6lhGIqJ1VteWij+6gBWA64p17JLwB/Tj3cIDF+Diqwa/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IJcHHLGV; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IJcHHLGV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786535029; x=1818071029;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hjekVHmV5srSlPUV+cmDzCU6AJUd4zvQcmdsQ1V5S/U=;
  b=IJcHHLGVPDeuERmKH4Sp8wGnNn0eZlGqGe2k4tqskUw8jAiP+Qpc70MP
   LZSeqHUZflx4rSBZQWlZ9XRIZndoLaQdQiEtm78HmEX2cXQFp/sa1wq61
   Mw8uYqhFx4nfIHAbPbSD1myy6Im9gQwYFX0A7N2ccp4Zx7/muFWqLvDs2
   ofA+nt8/Dk2hhMfKK1owz80xUOkeVR/BCy7AptmP0VhGQ312YZ43ayS49
   eHVBTaJOXFL86W0wo4kGSgujfn318rldYRqpqyI18m7aE/B7LR0cDfPpM
   qq+cYNfiU3h9/397ROeWVA99gS9SuUrSUex+tyTRvl4MDh4pde8Jnn54g
   A==;
X-CSE-ConnectionGUID: UOR73FsSToKJMWKMRUBLmA==
X-CSE-MsgGUID: Gx+OFr0eSAe6tjtndhHJTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="98445402"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="98445402"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 04:43:48 -0700
X-CSE-ConnectionGUID: NMKWxMH3QRuplyEjCff9RA==
X-CSE-MsgGUID: gw8zQ5mBQ7ySlU+8cZVpdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="257424093"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO mdjait-mobl) ([10.245.245.198])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 04:43:45 -0700
Date: Wed, 12 Aug 2026 13:43:35 +0200
From: Mehdi Djait <mehdi.djait@linux.intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, 
	Matti Vaittinen <matti.vaittinen@linux.dev>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
	Mehdi Djait <mehdi.djait.k@gmail.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kalle Niemi <kaleposti@gmail.com>, Topi =?utf-8?Q?Sonkaj=C3=A4rvi?= <sonkajarvi@hotmail.com>
Subject: Re: [PATCH 10/12] iio: accel: kionix-kx022a: Fix array boundary check
Message-ID: <anxb3anPmo3zjIV5@mdjait-mobl>
References: <cover.1786347811.git.mazziesaccount@gmail.com>
 <159f1048852afc74cfc2d219298a5a6f9d70cbb4.1786347811.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159f1048852afc74cfc2d219298a5a6f9d70cbb4.1786347811.git.mazziesaccount@gmail.com>

Hi Matti,

Thank you for that patch!

On Mon, Aug 10, 2026 at 10:54:32AM +0300, Matti Vaittinen wrote:
> From: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> The driver performs a sanity check for an array size, when converting a
> register value to an array index. The check incorrectly accepts the
> sizeof(array) as a last index, when last valid index should be
> sizeof(array) - 1.
> 
> Fix the check by bailing out when index >= sizeof(array).
>  

Reviewed-by: Mehdi Djait <mehdi.djait@linux.intel.com>

> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Fixes: 7c1d1677b322 ("iio: accel: Support Kionix/ROHM KX022A accelerometer")

--
Kind Regards
Mehdi Djait
