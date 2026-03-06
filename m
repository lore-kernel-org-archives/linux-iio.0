Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745F836827B;
	Fri,  6 Mar 2026 12:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772799054; cv=none; b=TrPH9FiiA2TNJc9EhQnUMubhd/wAY4fGU/8hxBLePZOfLZSpUz+fgNURgpfA4oJmd0Kxh4VqVlz4eA0V8OHdacIFlT1MvBDbAjw3o8cH0FIj7cePuUUe7q+Fi1QKgU4EFLnH+aAJGx00ZFH+13JHCyHyL/Hqf74DIjLcEWfptPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772799054; c=relaxed/simple;
	bh=B5zyNtA8RUGaQnpXYzohEYIM7Y4wffPpb+CBZysbP/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lb7LIirgVqeX1vdKag8Q+ME6wFrDldrHiVwnbpOSbBbseAHOEfOC+Te721AUPlm4LeystxlDpkyNvr2pHz2pWPYm6LGiQ/PERXymnIMTM01+MtOtD9E9PtVa2xWG+adWT+uKV1Wgef3shBe/7oixTT7ufmlgeh7EvppYwvmgmXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QLG/8NR2; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QLG/8NR2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772799053; x=1804335053;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=B5zyNtA8RUGaQnpXYzohEYIM7Y4wffPpb+CBZysbP/U=;
  b=QLG/8NR2UrE1Kefo9IBDnNA7aT5mOefSQ77C2Bc1fChjv0/K9YMe+u1y
   d3lo0j58HimlTKymRqEQH+kinMlEFPJ15zKmL0DB4Kh10XK+y2XKY8NB7
   Mrw9ArW89fngan2WBFud7d+sqrOp+9jMnDi7bc9r3fTzHrGZLY1gpO/3A
   2bfa91pQTtusBVLsSajD6swJ4NvDrh/ka2rHf4vBdVYGgo0Wy+ShMy9MK
   Ez4YEw0rZpX9s9WE1jYsfBtqSoVnkSrohW9wRh/9K6JyUpP+FJ8IMBxBv
   w7XzhsSiMeAuNjp5oIycpHvwHnnWdClEWkm5eIcL0TbRjZPG4HNmrGFuH
   A==;
X-CSE-ConnectionGUID: Zj+SGFddTRmvSnPuDudKFA==
X-CSE-MsgGUID: CbG/0skUQNaMj5LHkLhJ9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="74093718"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="74093718"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 04:10:52 -0800
X-CSE-ConnectionGUID: J93Q8krRREO4wO1LuImtjw==
X-CSE-MsgGUID: 21rElS+iRQSusnH5WRKz9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="249464388"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.1])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 04:10:50 -0800
Date: Fri, 6 Mar 2026 14:10:47 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Francesco Lavra <flavra@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 5/6] iio: ABI: Add partial quaternion modifier
Message-ID: <aarER76yQLyasKJa@ashevche-desk.local>
References: <20260304080519.2844101-1-flavra@baylibre.com>
 <20260304080706.2844472-1-flavra@baylibre.com>
 <aagc1_EkH3cqh41O@ashevche-desk.local>
 <a265489380e7abc9343c536185bc203688c5bd29.camel@baylibre.com>
 <ae79da24-1129-461f-a8ff-9dadfc863fee@baylibre.com>
 <0e808a2522e4021187ccf6aca5d8baae4beeed6c.camel@baylibre.com>
 <e145d179-d8c4-44d3-ac7d-1721b676cf01@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e145d179-d8c4-44d3-ac7d-1721b676cf01@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 05, 2026 at 08:40:26AM -0600, David Lechner wrote:
> On 3/5/26 2:50 AM, Francesco Lavra wrote:
> > On Wed, 2026-03-04 at 16:42 -0600, David Lechner wrote:
> >> On 3/4/26 8:21 AM, Francesco Lavra wrote:
> >>> On Wed, 2026-03-04 at 13:51 +0200, Andy Shevchenko wrote:
> >>>> On Wed, Mar 04, 2026 at 09:07:05AM +0100, Francesco Lavra wrote:

...

> >>>>> +What:          /sys/bus/iio/devices/iio:deviceX/in_rot_partial_qua
> >>>>> tern
> >>>>> ion_raw
> >>>>
> >>>>> +               Raw value of {x, y, z} components of the quaternion
> >>>>> vector. These
> >>>>> +               components represent the axis about which a
> >>>>> rotation
> >>>>> occurs, and are
> >>>>> +               subject to the following costraints:
> >>>>> +               - the quaternion vector is normalized, i.e. x^2 +
> >>>>> y^2 +
> >>>>> z^2 + w^2 = 1
> >>>>> +               - the rotation angle is within the [-180, 180]
> >>>>> range,
> >>>>> i.e. the w
> >>>>> +                 component (which represents the amount of
> >>>>> rotation)
> >>>>> is non-negative
> >>>>> +               These constraints allow the w value to be
> >>>>> calculated
> >>>>> from the other
> >>>>> +               components: w = sqrt(1 - (x^2 + y^2 + z^2)).
> >>>>
> >>>> Just to double check if we really do not have a special mathematical
> >>>> term
> >>>> for
> >>>> that already. If we do, I prefer to have that over odd "partial
> >>>> quaternion".
> >>>
> >>> A quaternion is often represented as w + xi + yj + zk, i.e. it's
> >>> composed
> >>> of a real coefficient (w) and 3 imaginary coefficients (x, y, z). With
> >>> this
> >>> notation, the (x, y, z) components are referred to as the imaginary
> >>> part of
> >>> the quaternion.
> >>> Alternatively, a quaternion is represented as the combination of a
> >>> scalar
> >>> value w and a 3D vector value (x, y, z). With this notation, the (x, y,
> >>> z)
> >>> components are referred to as the vector part of the quaternion; this
> >>> can
> >>> be confusing, since the quaternion as a whole is often considered as a
> >>> 4D
> >>> vector.
> >>
> >> I'm surprised there isn't a common name for this. When I went looking,
> >> the
> >> thing that came up most often is that Doom 3 used this in their MD5 file
> >> format. So maybe IIO_MOD_DOOM3_QUATERNION? (joking)
> >>
> >> I do think we could come up with something better than "partial" though.
> >>
> >> My first thought is IIO_MOD_3D_QUATERNION since it is a 3-dimentional
> >> number,
> >> but I could see that being confusing to some since quaternions are
> >> generally
> >> used for rotations in 3-D space.
> >>
> >> Maybe something like IIO_MOD_3VALUE_QUATERNION or
> >> IIO_MOD_COMPRESSED_QUATERNION
> >> or just IIO_MOD_3QUATERNION?
> > 
> > Or, since this represents the axis of rotation, perhaps something like
> > IIO_MOD_QUATERNION_AXIS?
> 
> Sounds OK to me.

Agree, this is at least better than opaque "partial".

-- 
With Best Regards,
Andy Shevchenko


