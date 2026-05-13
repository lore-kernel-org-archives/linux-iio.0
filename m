Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B80D395AD5;
	Wed, 13 May 2026 20:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778702583; cv=none; b=SUF9iDIYzyfr0xjr+Ab0ypI9neF+LhoDaENg7lhq0mm7iWbeajH6g10i1iNmvg/yLXS65o5xEeq7dvrfzl19bXq9aiy+1hSY+/JLYVnRDe7xzeG6KAB00xcEm3PU6S1gXZFOO0qgY7np6UqTTSUfqGhHJI3VAgyKNuYZg0VaMlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778702583; c=relaxed/simple;
	bh=Q5NUD8fTwnvmNtEBXEalQlErbRJbAPNtoPerctcXp2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKAaRi6dJxXfBGVTLjIvBjyavHmfSxxIJhKRUEc/rjNreEVIe//rClM+FBUFPKt/TqU3FQ6lZcXSEinbTpiX/WWBfcQ+nOYYyeJVeDRS8V8/b1xeqcySfzGM3bbf6xfKGIYAUuEVeJSfhWXeGrHS4zkzRCTjn4cX0zdWsLsyY8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KeHrZbQw; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KeHrZbQw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778702582; x=1810238582;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q5NUD8fTwnvmNtEBXEalQlErbRJbAPNtoPerctcXp2o=;
  b=KeHrZbQw+X0yFAdTDfgofYp0uMNU6cIoogUm83vJjuNIqP/NKUe9wJBC
   5UBvx9OAhlLkgUXrEXUK8jk+tHOScqzgD5ekAcxpYzIrdT7zJEbWYpz2t
   ay/7lqEPVe+or+N/3hOHynTeJv60YutE73tKroa2yew0VdAYiRTdiSSKK
   IcuRiY8tuIz2Kt9u+cqoSakkDFHGv79QSU3iqvESD9yXkJmxwLeyq3P7B
   fsyNar3++kt/9v1aDTX9xgHycaKPRAFjfqhjhTHp9l+63edl3njx+eiw0
   qAeHkO/+qRtf9h8sNIJcxGQKn/xZ8o4y9JmgrYovaK9JMO80TrJkFspMP
   Q==;
X-CSE-ConnectionGUID: LGiB2g6yT8SqIZk2tI4RtA==
X-CSE-MsgGUID: G2jDOizhTTizB8QLxohIzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="79497864"
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="79497864"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 13:03:01 -0700
X-CSE-ConnectionGUID: m6v3Y4luRACtzT4xtcID+g==
X-CSE-MsgGUID: YXu5eRIPRSC2Gm5sjYBe1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="240005073"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.106])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 13:02:57 -0700
Date: Wed, 13 May 2026 23:02:55 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] iio: light: veml6030: fix channel type when
 pushing events
Message-ID: <agTY71MPPJ1b7qLC@ashevche-desk.local>
References: <20260513-veml6031x00-v2-0-4703ca661a1d@gmail.com>
 <20260513-veml6031x00-v2-2-4703ca661a1d@gmail.com>
 <agS5Xu8ORtEwuwOB@ashevche-desk.local>
 <DIHR47ZGCUOK.2CNX05W0I8F6F@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DIHR47ZGCUOK.2CNX05W0I8F6F@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, May 14, 2026 at 07:13:41AM +1300, Javier Carrasco wrote:
> On Thu May 14, 2026 at 6:48 AM +13, Andy Shevchenko wrote:
> > On Wed, May 13, 2026 at 05:49:42PM +1300, Javier Carrasco wrote:
> >> The events are registered for IIO_LIGHT and not for IIO_INTENSITY.
> >> Use the correct channel type.
> >
> >> This bug was introduced in the first version of the driver.
> >
> > Unneeded detail, if it's a bug, use Fixes tag.
> 
> >> When at it, fix minor checkpatch code style warning (alignment).

...

> >> -	iio_push_event(indio_dev, IIO_UNMOD_EVENT_CODE(IIO_INTENSITY,
> >> -					0, IIO_EV_TYPE_THRESH, evtdir),
> >> -					iio_get_time_ns(indio_dev));
> >> +	iio_push_event(indio_dev, IIO_UNMOD_EVENT_CODE(IIO_LIGHT,
> >> +						       0,
> >> +						       IIO_EV_TYPE_THRESH,
> >> +						       evtdir),
> >> +			iio_get_time_ns(indio_dev));
> >
> > AFAICS the indentation is still broken. Why not doing like this:
> >
> > 	iio_push_event(indio_dev,
> > 		       IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 0, IIO_EV_TYPE_THRESH, evtdir),
> > 		       iio_get_time_ns(indio_dev));
> 
> Thank you for your feedback. According to checkpatch.pl, both variants
> are fine. Mine takes into account the indentation within
> IIO_UNMOD_EVENT_CODE(),

And still have broken indentation with the last parameter. So it's not fine.

> and yours only accounts for the indentation for
> the arguments of iio_push_event(). Moreover, your suggestion goes beyond
> 80 characters and mine does not,

When it's about readability the 80 characters is not a strict limit.

> so I would prefer sticking to mine if
> possible.

I recommend to reconsider. Mine has no indentation issues, the only subtle
"problem" is 86 character line. And looking at the result I find mine better
to read (hence the exception may apply and we are fine with the length of
the line).

> As I said, it passes checkpatch --strict without warnings
> in both cases.

> I will send a new version adding the Fixes tag and removing the comment.

Make it the first patch as the currently first one does not sound like a fix
to me.

-- 
With Best Regards,
Andy Shevchenko


