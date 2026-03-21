Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E4C3876A1;
	Sat, 21 Mar 2026 13:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774098930; cv=none; b=mTXCx9GMmrKOWibq8NlyccrUz9qSHQCh7TXji4D2a7mZMjOA3HFyN0buN5n/XR2QJaoH5iId3JBGm9PGOOWMArDFovl63AQA9k/2t+MyNmGyB8BQNsT/OZDQSYp2O3LWE4Sf3r1VuXr4iujNcrkyImuZo13LSYF5HPMgQBdvCZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774098930; c=relaxed/simple;
	bh=FVTw8nhS0BKMb5l3FxxyZDwWPT/6/ffqZN53a+Ah1UI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qbPTqrlKREXSEiUAmVRYxQGzl04YZM70SFYn+pz05JegNfACxQcaeAaK1YsrvWUWbp9ox1EsCDMrVjyOwmI1XctQUAlD1RMsEwAiRdKWTrt1rpOvQfEZGoSK70sZtkCfOlPSY/8Da6Hjpqh7pbhTMEEXQcC8vttVszConNRoANI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHsqMMRE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHsqMMRE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC247C19421;
	Sat, 21 Mar 2026 13:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774098930;
	bh=FVTw8nhS0BKMb5l3FxxyZDwWPT/6/ffqZN53a+Ah1UI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CHsqMMRES5oSS9CRgk2BL2P6GJcBwGqI7HkDqjHubDQnbz/2eR4xjcjsZLHeRa2hp
	 djF18R+2YfRN6ckZlvycrhw8j51gXs38JmIKer+EBmwL89BUu4xpSIdiG/CThbUOTq
	 LblDnEMvz7Do0Qci0k7GWU89CkkRdKB8z4FDRK74l+w+YAjiH8J0yIYWy/XNGJEevW
	 2zop7lAJTNcdR+i4zGmu6XzkFCKfJtWLHdOsI10bLhkEVIFrhtLhBcMnyRCLW9qvrB
	 TuX0R/3R0nvMLXP4fElVhCK35NWe+eekQo6QkTrawDmQcq8K0JVCPTCPV/i4kX9Sbd
	 wV37xUDzjJ5yw==
Date: Sat, 21 Mar 2026 13:15:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Gabriel Rondon <grondon@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, gregkh@linuxfoundation.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] staging: iio: ad9834: use sysfs_emit() in show
 functions
Message-ID: <20260321131520.3e2cce83@jic23-huawei>
In-Reply-To: <ab0CCzsu_nuPhSx7@ashevche-desk.local>
References: <20260319225719.73587-1-grondon@gmail.com>
	<20260319225719.73587-4-grondon@gmail.com>
	<ab0CCzsu_nuPhSx7@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Mar 2026 10:15:07 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Mar 19, 2026 at 10:57:19PM +0000, Gabriel Rondon wrote:
> > Replace sprintf() with sysfs_emit() in sysfs attribute show functions.
> > sysfs_emit() is the preferred API for sysfs callbacks as it is aware
> > of the PAGE_SIZE buffer limit. No functional change.  
> 
> ...
> 
> >  	else
> >  		str = "sine triangle";
> >  
> > -	return sprintf(buf, "%s\n", str);
> > +	return sysfs_emit(buf, "%s\n", str);  
> 
> Do more, drop these unneeded 'else' and return directly,
> 
> 	if (st->devid == ID_AD9833 || st->devid == ID_AD9837)
> 		return sysfs_emit(buf, "sine triangle square\n");
> 	if (st->control & AD9834_OPBITEN)
> 		return sysfs_emit(buf, "sine\n");
> 	return sysfs_emit(buf, "sine triangle\n");
> 
> But again, check what is the modern ways of providing static _avail lists.
FWIW, they don't work for strings and I'm not sure I'd want to add
string support!  

More generally good advice, just not applicable in this particular case.

Thanks,

Jonathan

> 
> ...
> 
> > -	return sprintf(buf, "%s\n", str);
> > +	return sysfs_emit(buf, "%s\n", str);  
> 
> Ditto.
> 

