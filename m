Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9411E7C18
	for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 23:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787355309; cv=none; b=DuphumBtGZ938UkJqRm2qyksg5wxoGBC0OLRiklUsdwqJSRI+3Hv3hrR6+VNzdJOtkdMbAQdg2HTHhUKw/SYnC4EKdpZIyT2NdLk3AERXPyaIkKdCJeTa5DaiNCIHsmcsqBdwCLEHlP18qnJHz6lO3jb6M5Ka/KgX6NcRpuKHRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787355309; c=relaxed/simple;
	bh=oxeN1sIW6UDRahugO74vDrxYsJuaqgIS7VhHVd8289Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tqbemm0ZYPtblzmkA5hTq9hQzoIcYHh4MiXnV+Oeke9GCzX7XxdCs4mnubLfdu8qo4ZT1GKuhQaET2QjCJd4xgxXHI5VouD4USS3LS3AWKVtwasx3yiXw7q9nO6QDOfeuWOU3QGvdT/TLx21Cz3eHmHwMhXsnqTIDNuRs9jmh1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nV58QJNJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nV58QJNJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94B561F000E9;
	Fri, 21 Aug 2026 23:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787355307;
	bh=risqopzzbL5dyHIytLaW9nalXpHSu6dIgaQsnI6V6pM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nV58QJNJJKNGyoXz2mfjCSumrRqZFmw1P4QfxrKQkUixFM4i+c4l9V81R1Un5rwdE
	 cX3+R21RZlbt4jewOH/NAc6wRjPnMeWJSyzt55mtRapdJrvzOgylq2CLsJynsPn5Nf
	 iRQsCa7eDNjJVobeAXyin2AlTV8PUtfZmqWd88lrsLrCtsDUSaaDwOxjaRKKVtmFRA
	 AH7qT2JWyBB3Kr+2ctO2e0xuw3si2YbIa4YEIlrDUdqZNl8ogcrxfRFfja2pct4nkd
	 p0zx5jAQD65Q6Wbjbd3k2pw/CO6MTBu6WAXRdzfDZDIXLjG6+4kiwYmF/hZGwnZEBG
	 Y8r4eOq9r+6mQ==
Date: Sat, 22 Aug 2026 00:35:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-iio@vger.kernel.org, Jinseob Kim <kimjinseob88@gmail.com>, Joshua
 Crofts <joshua.crofts1@gmail.com>, Sanjay Chitroda
 <sanjayembeddedse@gmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 sashiko-bot@kernel.org, Jonathan Cameron
 <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v2] iio: buffer: Ensure bounce buffer used for unaligned
 case is zeroed.
Message-ID: <20260822003502.79b9207d@jic23-huawei>
In-Reply-To: <anr6TMSfdmjQk3Oa@ashevche-desk.local>
References: <20260803012224.219493-1-jic23@kernel.org>
	<anr6TMSfdmjQk3Oa@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Aug 2026 13:32:44 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Aug 03, 2026 at 02:22:24AM +0100, Jonathan Cameron wrote:
> 
> > iio_push_to_buffers_with_ts_unaligned() leaks uninitialized heap memory
> > to userspace if the data passed in is not a multiple of 8 bytes and the
> > timestamp is enabled. Specify __GFP_ZERO for the devm_krealloc()
> > to ensure any extra space is cleared.  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
Applied to the fixes-togreg branch of iio.git and marked for stable.

Usual stuff about rebasing on rc1 etc apply

J
