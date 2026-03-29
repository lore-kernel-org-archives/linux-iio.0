Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96932C027C;
	Sun, 29 Mar 2026 11:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774784686; cv=none; b=pv/t6gXPjON1qiVacLlCEd5AvQJLxin9qk/jB1YWpGjIq8HyPkaXTweKBDJhsAtUNd5FfOpEtvT79aE5aQTnTfzaydsnxS80tQqH3W87g5BqmvHUfq11IlgIcn+Id+HxuvVABbfnyRJn5RrZuQleKHdK3nEiS9clzIzDqAkB15M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774784686; c=relaxed/simple;
	bh=D5iAEQPkFQWm4injXxqIxAXkOcm7afpN1Rs3qz7Hw0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JmFZMmFNxQNZ0YPaqmbVDZrTTUans2MXeIKXJ6SPXhXlIRR82Psxr/1hxHFE3fkbK4o0zREv6Oy7WfNzEwskf7kfehPcbJu7GTbqy9HiDJS84e6e+S/gjyOv/tmUzHbHyObrpjP248z1dirFQQbiwAem8KNEHnPtG6o11yH7/4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z9+OROKb; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z9+OROKb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774784683; x=1806320683;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=D5iAEQPkFQWm4injXxqIxAXkOcm7afpN1Rs3qz7Hw0Y=;
  b=Z9+OROKbhAeN5pgqsO4yFH8WR6VJ5bc1WVJ0kOmYLwg6AuR5K0hL/tYT
   lPaUV1n7XLfLKMDVn3imZrv7ZlRPWtzFrI/waHYh4bnCJ2sAuwKJrb0Dn
   RdqY9Bkn2+UMCJPXJ97mzW5Yk6rozTBPB8+PDVzB2CJwGXRawe2IY6sV4
   nFo4toixdEfFGnIb5Z+5BTNG8cvZRhjA1AL/u9Q8E1pfnHzhBZ3k0K0nm
   TRKoG0DSg7vx2DC+0jnuhPTkLAQ7QOY7+lFaGcn5/b7KP9WYrM60iJ3K8
   lX6euOsfqWeCYbrMUgvGIU2tiG7fiehPcHdLZDx/hBzPi8n4A/hV7S8wu
   Q==;
X-CSE-ConnectionGUID: NxuzGoICTNu/+f17bhf9yw==
X-CSE-MsgGUID: CFn3avyrT4qi+7Cs2eol0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="86101099"
X-IronPort-AV: E=Sophos;i="6.23,148,1770624000"; 
   d="scan'208";a="86101099"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 04:44:43 -0700
X-CSE-ConnectionGUID: NZtDlPxoSDiuQ/JgPNuJuQ==
X-CSE-MsgGUID: 8L73Jc4tSpOi9fiCQqRPKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,148,1770624000"; 
   d="scan'208";a="256295510"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.29])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 04:44:41 -0700
Date: Sun, 29 Mar 2026 14:44:38 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, kees@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] iio: ssp_sensors: ssp_spi: use guard() to release
 mutexes
Message-ID: <ackQpuBPZva28ZMd@ashevche-desk.local>
References: <20260326081815.925373-1-sanjayembedded@gmail.com>
 <20260326081815.925373-4-sanjayembedded@gmail.com>
 <acT6vokgYuUTsWcj@ashevche-desk.local>
 <4017E54C-B25B-41AC-B4E1-F28576C2D64C@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4017E54C-B25B-41AC-B4E1-F28576C2D64C@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Mar 28, 2026 at 12:24:11PM +0530, Sanjay Chitroda wrote:
> On 26 March 2026 2:52:06 pm IST, Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> >On Thu, Mar 26, 2026 at 01:48:14PM +0530, Sanjay Chitroda wrote:

> >> Replace explicit mutex_lock() and mutex_unlock() with the guard() macro
> >> for cleaner and safer mutex handling.
> >
> >NAK. Please, be very careful when do such changes.

...

> >> -	mutex_unlock(&data->comm_lock);
> >> -
> >
> >Pzzz! See what you are doing here...
> 
> Thank Andy for pointing this out — you’re right, using "guard(mutex)" here
> unintentionally extends the lifetime of "comm_lock" and can hold it across
> the completion wait, which is not safe.
> 
> I’ve reworked the change to keep the original locking semantics intact:
> 
> - "comm_lock" is still explicitly unlocked before "wait_for_completion_timeout()"
> - No sleeping paths are executed while holding "comm_lock"
> - Introduced small helpers to simplify the flow:
>   - "ssp_send_and_enqueue()" for SPI write + pending list add
>   - "ssp_dequeue_msg()" for safe removal from the pending list
> 
> Updated flow looks like this:

If you are going to mix mutex_lock() with guard()(), it's even more NAKish
solution (id est worse than no change).

> This keeps the synchronization boundary unchanged while reducing duplication
> around pending list handling. I’ve also limited "guard()" usage to short,
> local critical sections only.
> 
> Please let me know if you’d prefer keeping the list operations inline instead
> of helpers.

-- 
With Best Regards,
Andy Shevchenko


