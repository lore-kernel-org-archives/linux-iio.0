Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC033FF88A;
	Tue, 26 May 2026 14:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779806989; cv=none; b=rxyyZiLgaLm39EyrVacH5JuRAF8oHJ52FKW8AChr8VuO3BjCaaAooVrZZHPgnSqo3BPBEz8VnbYUomP5UX9aJrO7ac7bTH4yiHh3f67dgapk6LpjvG5thyHpK4yb3qRp+YdcE0aRe4qxkKhR213ZFCKD3U6ZavDhVjZPZ2RfdvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779806989; c=relaxed/simple;
	bh=odutlCxdgPvaOXmqem1ok7F1kHYJLnr6QBXJHgCna04=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B50RJ6Zc9ocJSRUujVmOJT8piJeKIlR15dlk5ZWPnNWP1v+/D+vM2ES6op8ho4vp8Nui9RByKYqcJzpEqbngR/xGkROBQBHd3t0DBJo6G1LFyoG3T1BtWyYDNfAgAwi50rexNIq0JzRyTF0LxCmxKWaJX6ZSoVZRNQbTNS4x9mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yu8mm6Md; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yu8mm6Md"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831B31F000E9;
	Tue, 26 May 2026 14:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779806987;
	bh=M8bN1TG/0hAjw3DVWJQYxZDwI7+hgishc8/07CIciTk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Yu8mm6MdBSpSn5F1+hFmzR/Ib+OjVyIRjxu15H+TW+WoNAgYTBgRo+jOkz/sN3UL7
	 SDP4M1mhFqMgyiJBFhhvsc8GW8kppWvgeAiKHnKA93O+Ls4zdtHay1MTkJn+nfVO5l
	 scqFI4TFWW4n61nj9JUEAxQabplMg/VzgLEXCc+pvaCd8oPAwK1iF/J75TN7Ic83If
	 dkCFMMmMSObLBxcF1AgBMjcsXf0LsSrQyG+zEgxK6frG1BWKml+UTSf3RSu6hPS79C
	 OSD0QOiQodyNaVLFIk4036sVV/VRX/5AAl5neZ0W/q6lGjAi6oiPQswFvw52yRHlpC
	 hmvxsch4WDLaw==
Date: Tue, 26 May 2026 15:49:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Tomasz Duszynski <tduszyns@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org (open list:IIO
 SUBSYSTEM AND DRIVERS), linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v5] iio: chemical: sps30: Replace manual locking with
 RAII locking
Message-ID: <20260526154939.5813501a@jic23-huawei>
In-Reply-To: <20260523181536.5254-2-m32285159@gmail.com>
References: <20260523181536.5254-2-m32285159@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 23 May 2026 13:15:36 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> Replace manual mutex_lock() and mutex_unlock() calls with the much newer
> guard(mutex)() and scoped_guard() macros to enable RAII patterns,

There isn't any scoped_guard() left in here.  I'll tweak

> modernize the driver, and to increase readability.
> 
> Move mutex locking into sps30_do_meas() and tune it up to use guard()(),
> as every caller takes the lock anyways.
> 
> Signed-off-by: Maxwell Doose <m32285159@gmail.com>

Applied.

Thanks

Jonathan
