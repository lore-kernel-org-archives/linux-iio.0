Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821A837D105;
	Wed,  8 Apr 2026 11:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775648181; cv=none; b=WZBjqmPTLbqLG6HnMnDtljE/JT5MxPo5LcO7XzeWznRkhUQzOMMRdqqbfYqeNNIehxXHalVvl/6Qk6U7p1aHGGNlsPUiWPbQ5+z8JRtG/UygE+aqMIuBP1n4UX+5ibjZeaU5oalemdOzD/xLRBPJKlmWEWX0wSse244horaS9N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775648181; c=relaxed/simple;
	bh=1TDPGtygqzYEHFncW8hn011RsZuogmikZdlgF3nIzQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZxCCElZy7prbLyDLDLaITatc36N1wUW6EjdEHRuSZjosBXOjQzvxGn/wM8AjoCCVYCjwMoJYc55d+A4CYnIj20UYCKtIuNc5pZZTAd6LPVXc1giplZsDTIWrSvoXMYmiiXWcB2XlkpyCWat8WAWMyTH24oF3FlJKQ/ZArHt3gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WKCAhrFe; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WKCAhrFe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775648180; x=1807184180;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=1TDPGtygqzYEHFncW8hn011RsZuogmikZdlgF3nIzQk=;
  b=WKCAhrFeLHHtrFfFu5kVFMIKbguyQAzIOmHYaAv4rwi+KoVa9vH8ACGL
   mqSw0bu3ORsMdSb8ccgktzHoY54WEFeR9HTecwrdnlYBOcV+Jn+cep9CG
   h+0qMChl9wF3+VMujLQLQv3vz91N8YBjz78wvD05ncVq/ZxnV7CaJ3/+Y
   nhrcaJBzSIeA94T9OEvqj0vTb6D8IncEqXhgSUNbDNHzvTiFD7Ykjq6ir
   JG4IvKKilhiOy7UzT4WE7/a7OrwZvq7UICwtbYeMBSuY7hxxAH7djZ3ch
   mb1R3RNDaXpFKq+4JdMsBA3RHhEcwG2iXg9jMk4Ue3/XlyTYOo+Yqngig
   g==;
X-CSE-ConnectionGUID: /959CEbXTGKgP7DqIREbUw==
X-CSE-MsgGUID: GvU17J+nT3eIaWNjdSnulA==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="75798506"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="75798506"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 04:36:20 -0700
X-CSE-ConnectionGUID: V6RS7qp/Sv6vInkdQQU3/A==
X-CSE-MsgGUID: WyuUuRAgQlGeN/HKWXwL6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="225270050"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.72])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 04:36:18 -0700
Date: Wed, 8 Apr 2026 14:36:15 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Embedded_SE <sanjayembeddedse@gmail.com>
Cc: "jic23@kernel.org" <jic23@kernel.org>,
	"dlechner@baylibre.com" <dlechner@baylibre.com>,
	"nuno.sa@analog.com" <nuno.sa@analog.com>,
	"andy@kernel.org" <andy@kernel.org>,
	"kees@kernel.org" <kees@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 3/5] iio: ssp_sensors: factor out pending list
 add/remove helpers
Message-ID: <adY9r23FEXcqYZZa@ashevche-desk.local>
References: <20260406080852.2727453-1-sanjayembedded@gmail.com>
 <20260406080852.2727453-4-sanjayembedded@gmail.com>
 <adQR2ZKVOavHlJDt@ashevche-desk.local>
 <FA511CDD-1F98-4E66-BCE8-5156DBAF4359@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <FA511CDD-1F98-4E66-BCE8-5156DBAF4359@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 08, 2026 at 07:32:48AM +0000, Sanjay Embedded_SE wrote:
> On 7 April 2026 1:34:41 am IST, Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> >On Mon, Apr 06, 2026 at 01:38:50PM +0530, Sanjay Chitroda wrote:

...

> >Suggested-by?
> 
> Requesting your input on which email is recommended to tag with your name.
> 
> Shall I use intel.com ?

The one that was used in the message which suggested this change. I don't
remember which one I have used.

...

> >> +static inline void ssp_pending_add(struct ssp_data *data,
> >> +                               struct ssp_msg *msg)
> >
> >Make it rather:
> >
> >static inline void ssp_pending_add(struct ssp_data *data, struct ssp_msg *msg)
> >{
> >       if (msg->length)
> >               return;
> >       ...
> >}

> It should be not, right ?

Yes, too many negations, perhaps even better to spell it as msg->length == 0.

> {
> if (!msg->length)
>         return;
> ...
> }
> 
>  const bool use_no_irq = msg->length == 0;
>  if (!use_no_irq) {add/del}

> If message length is 0 then no interrupt

-- 
With Best Regards,
Andy Shevchenko


