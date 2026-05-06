Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01B023D7FF;
	Wed,  6 May 2026 13:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778072908; cv=none; b=KUbdND9EoxIdG2oQY/ISJ06GjAWvOgl/rYMWl2upuwYOZ9Vlv0HhxtgmfFaUjQVUYzVzImKy90GlS9uF+1NAErLRjU1ok47ETZttfKkaeiSA681iHd0Gi/jY+EhjVD1qJ83pPjowpKRAAGzgukYFOvVIOZZ7TRR7IUaRgGNPoqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778072908; c=relaxed/simple;
	bh=ovFdm4PUGmprJ4eBv2Y/WIgQx6h6RYVqqakJYONUPv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdHksKZKPGKC9nLRGtJLvqx+Cgu0ewkCCa3nOACwb8ZWSlPVrS44v3bJBRsf6SjgGHa8OF2lIlVNxikIebkOpwbkrAtkVIJ/Xqj4OoYss8hQGuih8wRkUUuktVgTOEfFicM6PdJXZzlql5oL4hpcQ08OtyKBxXLq9HCdBu3U4l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U/DjeH7j; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U/DjeH7j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778072907; x=1809608907;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ovFdm4PUGmprJ4eBv2Y/WIgQx6h6RYVqqakJYONUPv8=;
  b=U/DjeH7jO88YoIsFIg0vs6OR8JHWGwDGuGlhhcYdklCly8F+ArMiGgeY
   TFFZenf5J8p2rLI/MavTxtNhyRw1+QTKZutXfAhPqz780JMTWwn9S7Stt
   tGSYbnX//dIL0+egpC49dqeUyYKrrvIChxCxyQFHgSLw5F7Wy0p6g2I15
   weDB+rucmVxWRRsMoeK6btmD3LqwK6C7qC6yUun1JVo7f7vqyArJrwSMN
   s2E6Qq4Pwt00JlfpMkNBeDMkwOhlzxND2Qc98+TQ7DdMmD5yxt2EiQM75
   GLDxD12S8bN8N9y8s/xg9qnutQTEfoe/Ps6hYgIra+xgunGH8EJO7Prus
   Q==;
X-CSE-ConnectionGUID: hddR8pH9S4yZDCfLI7mykg==
X-CSE-MsgGUID: jfWej7LNSbGbVopJ9UCCuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="78893451"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="78893451"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 06:08:26 -0700
X-CSE-ConnectionGUID: aLJNDU3iRtuL2O7n1VrmHw==
X-CSE-MsgGUID: sX620JRgQ5+fvuOWM4GtSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="240475892"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.183])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 06:08:24 -0700
Date: Wed, 6 May 2026 16:08:21 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 07/18] iio: magnetometer: ak8975: modernize polling
 loops with iopoll() macros
Message-ID: <afs9RRAldVXWqVaZ@ashevche-desk.local>
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
 <20260505-magnetometer-fixes-v5-7-831b9b5550fc@gmail.com>
 <afrlT71SjyQLh2xz@ashevche-desk.local>
 <CALoEA-xjvxYOQ8Kt+OXR=6E_TrjUmC4J6ZXftE6hri6z+Wzhrg@mail.gmail.com>
 <CALoEA-xBcPzoy4T3+0edrnQLV++k2VN5ozWan8L+gnV5P3CLFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-xBcPzoy4T3+0edrnQLV++k2VN5ozWan8L+gnV5P3CLFw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, May 06, 2026 at 12:50:09PM +0200, Joshua Crofts wrote:
> On Wed, 6 May 2026 at 09:01, Joshua Crofts <joshua.crofts1@gmail.com> wrote:
> > On Wed, 6 May 2026 at 08:53, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Tue, May 05, 2026 at 01:46:03PM +0200, Joshua Crofts via B4 Relay wrote:

...

> > > > +     ret = read_poll_timeout(i2c_smbus_read_byte_data, val, val != 0,
> > > > +                             poll_ms * USEC_PER_MSEC,
> > > > +                             timeout_ms * USEC_PER_MSEC,
> > > > +                             true,
> > > > +                             client, data->def->ctrl_regs[ST1]);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +     if (val < 0) {
> > > > +             dev_err(&client->dev, "Error in reading ST1\n");
> > > > +             return val;
> > > >       }
> > > > -     if (!timeout_ms)
> > > > -             return -ETIMEDOUT;
> > > >
> > > > -     return read_status;
> > > > +     return val;
> > >
> > > Besides the unneeded return val duplication, I think this is the wrong location
> > > for this check and it changes behaviour (really subtle change!).
> 
> Hmm, rechecking this, I agree with the unnecessary return, but I don't think it
> changes the behaviour of the function.
> 
> > > Before if the last iteration gives an error from the device, we return
> > > -ETIMEDOUT instead of the whatever the i2c_smbus_read_byte_data() returns.
> 
> Looking at the original function, it always prioritized returning the
> i2c_smbus_read_byte_data() error code before returning -ETIMEDOUT (even
> on the final iteration). In the new version, if the i2c read is bad,
> the read_poll_timeout()
> code will still be zero, therefore allowing the code to jump to the
> i2c value check
> and then return if bad (this is still the same behaviour IMO).

It looks like I stand corrected! Indeed, we have two conditions to follow, one
is provided in a macro parameter, and the other is for timeout. Here the Q is
which one logically should be checked first? More thinking on it tends to your
direction as it follows usual pattern as we check the return values (errors)
from the callee first *then* validate the results.

> Maybe I'm looking at it from the wrong angle though. AFAIC Sashiko nitpicked
> everything except this (but yes, it's still an AI so we have to tread lightly).

> Same goes for the other patch where you raised this issue.

Yep.

-- 
With Best Regards,
Andy Shevchenko


