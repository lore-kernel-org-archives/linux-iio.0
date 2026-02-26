Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6212A399006;
	Thu, 26 Feb 2026 09:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772099770; cv=none; b=JTvcazAUnDSO1q4+ucAJBl4hroloKYG/mjBhxkrE6CWzdALhTRCHf0yB6MOi0eEwt24T1x6esYoQYVaFXV4qVbXR9oiAk+LkJNR6MV8mttG25+TlRXouxgp7qBbD5PD9B33KwtiICwYwpC3Xw2c1G/fAqV77P3FytUhQRKYdH+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772099770; c=relaxed/simple;
	bh=Sb+BxmsHyenTF6+5/pLxUamseJskPbfIMoS3SAPH/hE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbtiTsmM7aqShi7NfcQ0x/jM7oQQklyV044prKK9/MpVOVRf1pG1nSP9b5Cccz+FBClnwLOZbOqfnEKi40N6nIC3/wSybkDGdC16Qiqz7dfzSzW2StA99AFXfGf75ic+H/m97EA1mm157dDFRGFWaK7JNVwjpWYi7tB093vk1Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FBvKpNTt; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FBvKpNTt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772099767; x=1803635767;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Sb+BxmsHyenTF6+5/pLxUamseJskPbfIMoS3SAPH/hE=;
  b=FBvKpNTtyar50PWPigHI+BVBbfzS3xoLfdlq2UwwcBHiob/cKt9jLfQF
   klvdJcwt6ia53lmPCCZSRqsveUgtMA5fdl7+csSFZQof/PkZpEae4figN
   yzY/GEL5yl6hfieTxeaCfNi269UYo7QcEeGLTrzVYv9590vvUqO68srfs
   lBAZ+WLIKcsGWmj8LiUMs7lB45k8oJDnlukxg9FVMBBUCARzA4CCVYMLp
   NibDOpl00WwRgiNvyKrbDETktk1I5nWzpOf1fYPeqioTWodH+6uvlH9SZ
   a3mL65nsDfpxH/IubdD06ywsAFigYhvqRvKbvvA+8LNYi+44hcVYt/W48
   A==;
X-CSE-ConnectionGUID: 4NTg0mxmQba67TopwrUMdA==
X-CSE-MsgGUID: QzChie1CR4ek/aoLPD/fLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="73068042"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="73068042"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 01:56:06 -0800
X-CSE-ConnectionGUID: bkLvJ1ZsSpuAjazDlUEeCw==
X-CSE-MsgGUID: nx2u4MgrQX27Z238m418Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="221134312"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.167])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 01:56:03 -0800
Date: Thu, 26 Feb 2026 11:56:01 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Francesco Lavra <flavra@baylibre.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/7] iio: imu: st_lsm6dsx: Fix check for invalid
 samples from FIFO
Message-ID: <aaAYsblcnf4SEe_X@smile.fi.intel.com>
References: <20260225100421.2366864-1-flavra@baylibre.com>
 <20260225101711.2368206-1-flavra@baylibre.com>
 <aZ7fbdpWRFsvpGWf@smile.fi.intel.com>
 <CAMuHMdXMOvWQ1T8CMDvR5XFBxO8m1ai8m982R8Nyf9LXiE7K5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXMOvWQ1T8CMDvR5XFBxO8m1ai8m982R8Nyf9LXiE7K5Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Feb 26, 2026 at 10:43:34AM +0100, Geert Uytterhoeven wrote:
> On Wed, 25 Feb 2026 at 12:42, Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Wed, Feb 25, 2026 at 11:17:11AM +0100, Francesco Lavra wrote:

...

> > > -     u8 iio_buff[ST_LSM6DSX_IIO_BUFF_SIZE] __aligned(8);
> > > +     struct {
> > > +             union {
> > > +                     __le16 data[3];
> > > +                     __le32 fifo_ts;
> > > +             };
> > > +             aligned_s64 timestamp;
> > > +     } iio_buff = { };
> >
> > Hmm... Have you considered m68k case? IIRC there the alignment is 2 (even for
> > 64-bit members), so theoretically the beginning of the structure can be aligned
> > to address 2. and hence the __le16 data[3] will have no gap to the following
> > timestamp. In current code it's 64-bit and not 48-bit item.
> 
> Fortunately, the layout of a structure does not change because the
> first member could be stored at a less-aligned address, as that would
> make it incompatible with a different instance that is stored at a
> differently-aligned address ;-)
> 
> The alignment of a structure is the maximum of the alignments of its
> members.  So that will be 8 bytes, as the aligned_s64 definition has
> an internal "__attribute__((aligned(8)))".

Thanks for the elaboration on this case, my knowledge about m68k is too shallow!

> It would be wise to add explicit padding ("u16 pad") just before
> timestamp though, for documentation purpose.

__le16 :-) Something like this:

     struct {
             union {
	             __le16 data[3];
                     __le32 fifo_ts;
             };
	     __le16 reserved; // ...compatibility with the previous impl...
             aligned_s64 timestamp;
     } iio_buff = { };

?

-- 
With Best Regards,
Andy Shevchenko


