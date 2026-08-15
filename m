Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282CC282F03;
	Sat, 15 Aug 2026 20:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786826726; cv=none; b=sZxZuib8EJ4ewJL91QTpP5lkoHGhn5f0ttDT11Hjx8Hx+86RRovm+e7D3oFXA+UfkKhJjl5HEXdfvG5zKCclOwzzqcvRqhDkMQ9N7sri8BZxy1R6jcazgV3IbIgrKIgSKmRQiC5Ckru2hSMPQ6OKLJuMMUYgjvipjr/5xb+qlZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786826726; c=relaxed/simple;
	bh=u28YY1RuVu93xZFHwPD1+GqBuIsWBuN0H2bC2+rr5/c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J/nbVEDQxerQlj7f4OXcaUk/khFZgOCY9nehbzeu66TaK8dDEsjnmWDc9zXMEYLDdCoqahVqVr3rN40IxZQe0uz4rI9dYGiF8qfM+P9aqKAkPO/ucL7GQph0aKKUoRoMCiH5dOmYRrW0CZ7r4ecYyK5BTMfAfW6g30AqFLMifaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLA7Admt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLA7Admt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E93761F000E9;
	Sat, 15 Aug 2026 20:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786826724;
	bh=A896n1kZd00IuS92v+EMMBm321KjulUAmBp6I5eXNw0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aLA7Admtwgb19ZoRiqrLcuUz0VBgjF0Ta3KV1AM2iydvwubmfH3KCd5+UU3mkzMaV
	 +1S8/ilJ3TDBuk0/j/P1j9ebugxkIZPYJw3764hJ8iTupjWfQkJzx+ciAkFZSndGnl
	 Xve9ktQoPs5KOmPr/2EzoO8aYqOuc5kLcDr1Efc0Q671Ez6k9NAqstDbJO5f9PMWB3
	 T7wYWVMid2Fl9sW7j3nujeXWkXNvZXH5chzbHDIKKQLEUJZobevVzoUlSX70KQKW3H
	 6fw+3xnFpXb5irvA39ywFMCjyZmzdXcavKiFAT26gKAG6jD7isF5btiq6cuR1GPebr
	 cyNJaFGMp7TuA==
Date: Sat, 15 Aug 2026 21:45:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Linmao Li <lilinmao@kylinos.cn>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Chris Morgan
 <macromorgan@hotmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH togreg v2 0/2] iio: imu: inv_icm42607: fix PM error
 handling
Message-ID: <20260815214520.73e369b0@jic23-huawei>
In-Reply-To: <20260811020345.950137-1-lilinmao@kylinos.cn>
References: <20260805035451.487465-1-lilinmao@kylinos.cn>
	<20260811020345.950137-1-lilinmao@kylinos.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Aug 2026 10:03:43 +0800
Linmao Li <lilinmao@kylinos.cn> wrote:

> The recently queued ICM-42607 PM support has two error paths that can leave
> the PM core's state inconsistent with the device.

For IIO at least (and I've never come across a subsystem that asks for the
style you have here) don't send new versions in reply to older ones.

It gets too complex if there is a lot of feedback and generally pushes
your patches many screens up from the most recent in potential reviewers
inboxes.  So you'll probably get fewer reviews.

Jonathan
