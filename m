Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509753290B1;
	Wed, 12 Aug 2026 07:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786518430; cv=none; b=CWdKrYUgnVKr7nf1C+F22m68tCEomtp17qKV80LaC2csQ3ad5Xh1QAcubUq3p3W04CeL8TddDTwr37gpk435956J/mosF0rLORmmPR9HqgmZFO9O42Go0nm06bYCPCvHZNtHKvoWPpKuyiHEkmEf+SihZ+VqdVHQB9n59aMprAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786518430; c=relaxed/simple;
	bh=bidLcxrQ7ZXLiPypBzpcDf8b+4ktOMzk0SS7QFVH6jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9Sk1yBLW0qYtimKo5quhUpluGL9Nxor6u4ZzqSCG7934uL51f4vGDhG8S+5rx7slpgs3zv1VL8o2kHjXHlCYxkZi3OarZ9rv/Y769jK6RZznRQDbE7cov7vHm4UshSby7A0Ml56MF4dw+0zQCv8fIBFZ0vdf4wim19ZrQY22Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RUzMiBcR; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RUzMiBcR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786518429; x=1818054429;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=bidLcxrQ7ZXLiPypBzpcDf8b+4ktOMzk0SS7QFVH6jc=;
  b=RUzMiBcRSBZYjH+D1/7UFNwfeicbZ7R8N0XkrFRwXirUNr7atQ4h21jD
   4AlUZpRrDSqswKnzrZEigLLwIj0PokCcPZlqMSZW/+kurg+0eHGySr3On
   S8O5MizZUlkNmhVsLwDSecC+8oCPL6Wx1/2hEXs/dTcwQB07hFzJRuldh
   HlECcKJCaVnxZaSyxiXyjq7pIcaWg+yJZabGANGBAIcZv4MZQ0CG/J12P
   w0+66s2bNPgn21lTLq3dXWiObAabAjqVrv8EoMPi80QcGjCr3DtSXLKnf
   vjvPpXSVh+XQC1f4RmjI0XrKNLiaOYd71SUaVjZSw/taBgLOl10yx7zqS
   w==;
X-CSE-ConnectionGUID: Fr+grQoFQ4emSBambyDvFg==
X-CSE-MsgGUID: k0w/WQ68SRK5bBOXBFOVtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="97726207"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="97726207"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 00:06:31 -0700
X-CSE-ConnectionGUID: tEApZ2tHQ36luwchycMeIA==
X-CSE-MsgGUID: RK2WkkrBQ5GXBglCWWqLsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="286988306"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.92])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 00:06:26 -0700
Date: Wed, 12 Aug 2026 10:06:24 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Michael Walle <mwalle@kernel.org>
Cc: Janani Sunil <janani.sunil@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org, jananisunil.dev@gmail.com,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v2 5/7] gpio: regmap: Add runtime PM and
 read_output_reg_set support
Message-ID: <anwbcDG6BEciTILK@ashevche-desk.local>
References: <20260806-ad7768-driver-v2-0-027ac5e2a641@analog.com>
 <20260806-ad7768-driver-v2-5-027ac5e2a641@analog.com>
 <DKMRF7SNHX5L.263MVTD0EZHD3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DKMRF7SNHX5L.263MVTD0EZHD3@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 12, 2026 at 08:43:20AM +0200, Michael Walle wrote:
> On Thu Aug 6, 2026 at 5:41 PM CEST, Janani Sunil wrote:
> > The new pm_dev field in gpio_regmap_config allows a driver to supply a
> > device for runtime PM. All operations call pm_runtime_resume_and_get()
> > before accessing the regmap and pm_runtime_put_autosuspend() on return.
> >
> > The new read_output_reg_set flag when set, gpio_regmap_get() checks the
> > pin direction first and reads from reg_set_base instead of reg_dat_base
> > for output pins. Requires both reg_dat_base and reg_set_base to be
> > configured.
> 
> As already mentioned. please split it into two patches. Also, could
> you add some context where/why this is used/useful?
> 
> So, if the direction is output, then you just read back the set
> value (instead of the actual line state). Is that correct? Why can't
> you read the input buffer in that case? Input buffer deactivated?
> (NB. you can never get the real line state in that case, which is
> sometimes useful for debugging.)

I understand the concern, but this is debugging of HW via SW, which I think is
sometimes not possible (not all HW supports it) nor good for production in case
some glitch happens and one reads back not what was written and hence come to
async state with the actual flow. Yes, SW might use GPIO output buffer as 1-bit
variable (it's another story to discuss if it's reliable / good design, but it
is possible and I have heard of a such usage IRL).

TL;DR: I am on the side to return the output state when direction is output.
Also note, some cases might specifically disable input buffers in GPIO (for
example to save a few dozens of µA per pin).

> Anyway, you should be able to achieve the same with the
> reg_mask_xlate(), no? Check if the pin is in output mode, then
> change the &reg.

-- 
With Best Regards,
Andy Shevchenko


