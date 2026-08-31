Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1927DE571;
	Mon, 31 Aug 2026 00:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788136921; cv=none; b=ZFKd5CANgxDWueE5Dg4cP3QoHDbJbfShZuKqOEFYVE7J0syC1538QgOCS0lroAsqZ6mfYNJEprmvaBIGSh6cD3W0rQwx6cBkoLci19YO/X4XxwgtIJ8aEHPhcXu48q6f+tsTPt/el4cHFFBGNFuhdLcc7qulHhgNITKKz5HMcno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788136921; c=relaxed/simple;
	bh=Va2nVMvF4tdrSfcTdmGWvv6ZdBLUhrd9nazicKWzj6o=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=stQKuwTSuqU2Jq6lw4AxKbR8Rql/BAco5zr2tvuuUrerCUPoBsHBMEW8CJcvbLqpFGzG1fi/f8oDjFNg2TWboIChy9NJiagAh15PhG5YYtDNmtOghYcO/f56B0hkRCJbWF9OsfGugF2Zcy9m2shfUYHBubLPgGK1MfaLu4JpD5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/ktwCnq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/ktwCnq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A86CF1F000E9;
	Mon, 31 Aug 2026 00:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788136919;
	bh=OLOC2S+02tg6JAR36TaW4fxJhC3mIL2wPvhEoBNhqvY=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=M/ktwCnq1UxuL7TL4qCoxqGLHXcCfguwsMXygm3xLLRDvB0O2ds5zrFVQV4iGRHaz
	 Nhln/XTw7IhmUqW9saowdouhuGxKcdhdeCOeMAJrSgbH2TzFbSOBaNa9NyBdn0bKo1
	 NTJ+sFQn7y6dOhlfnI5D0VV0Ez0kIgPflVWW0+N5OTcr7WtB9EHggg/vtTSLpoHsGn
	 A466N9LKXS1daiQEUKEePDQ38JbGje0ZiumCUA8oyRdf21lKbomd8cHhDGJenyH3v1
	 /WWKM9mD51w/M/1aQRROT7LS7YBL3lrhKKGhY6BtHtN7g1IJcqli+tAbq1W2IJAtDS
	 2n/5ZuJj99a4A==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 4/6] iio: pressure: dps310: add triggered buffer
 support
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Rupesh Majhi <zoone.rupert@gmail.com>, 
 Andy Shevchenko <andy@kernel.org>, Bill Wendling <morbo@google.com>, 
 David Lechner <dlechner@baylibre.com>, Eddie James <eajames@linux.ibm.com>, 
 Joel Stanley <joel@jms.id.au>, Jonathan Cameron <jic23@kernel.org>, 
 Justin Stitt <justinstitt@google.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
In-Reply-To: <ao1bBFkLXIIgNl49@ashevche-desk.local>
References: <20260824201203.396651-1-zoone.rupert@gmail.com>
 <20260824201203.396651-5-zoone.rupert@gmail.com>
 <ao1bBFkLXIIgNl49@ashevche-desk.local>
Date: Mon, 31 Aug 2026 01:41:46 +0100
Message-Id: <178813690647.2788519.5367342639957476343.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1342;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=Va2nVMvF4tdrSfcTdmGWvv6ZdBLUhrd9nazicKWzj6o=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqlM3KnrVra9pc7LX4upS85Jp9VQQ/zTrvwfBSy
 L07L3nuKEaJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCapTNyhEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiI/kD/0UyHuKncW8WGzqfXSq1YmGqgew/WEyW4OclcFSO/cez4Z
 JX4m7jNf1XJviqh/MsQXqU70GQvZwuVY+C+4RGXcKOHFR17+PBjPdRKsqCOXLyyVMZlYyTElpmT
 apOcNrpMGT9Qq3yATqbswE4eqwLTNyAY62mRt6oGZYtiV4Tl9F+tnY6hLUfLVuzorqSD1sP+lgf
 Lm7xSSN5vJKdfa9vqD4kFuh9rBavL4aPlX4VkpMz50nkkfihdN5UUya2ezieTbgsVg4ulRiSH8N
 auqviDH7cvwzokLRZRFWh+uCuwVRuPvNVdZQJeDUIysA84Qyapy5Osf9iAttVwTXZJYVbehOIiT
 XjFEWPmilb+QXoGYLK2f3XamV3kOjtN6oLyJRDpOnVjJcs4AxLVCXIj2x+SYxxpECQj9P+EdiQh
 70hEFQSCUsTF021qHJH2sh/BAgqRYvNi+77dcZu+Ax1DSY1Om71L5WpG1v2PUAzgsdLBUD/ZRgK
 e4rWjZteZTlgfxb1IwDGDveC5H8pnd8DAPFHKZoNbe9erUfBXYpl4PgR+GNA0hEm1iXcweyGRrL
 Qxo4wridei15pFU0GVlAiioLSnoSYPXUXPTJbtqlaVHCbgVJ3aEI1OS3aYQFjvjHm9M9MNEIjmL
 Dy6VX0tnw/4vwGOMdtwxrE+c4Prx+HC9RHlCnog==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

On 2026-08-25 12:06:12+03:00, Andy Shevchenko wrote:
> On Mon, Aug 24, 2026 at 11:12:01PM +0300, Rupesh Majhi wrote:
> 
> > Add a triggered buffer in order to capture continuously on both channels
> > instead of one sysfs read at a time.
> > 
> > Raw register value is not useful on its own, pressure has to go through
> > the compensation polynomial and needs a temperature reading. Report raw
> > in Pa with 1/1000 scale to keep full resolution in the buffer without
> > changing what the existing processed attribute reports.
> > 
> > Raw and processed reads return -EBUSY while buffer is on, so does any
> > reconfiguration.
> 
> ...
> 
> > +struct dps310_scan {
> > +	s32 channels[2];
> > +	aligned_s64 ts;
> > +};
> 
> Wondering if using macro here would make sense...
Hi Andy,

Do you mean introducing a new one or using the buffer ones?  I'd
rather keep explicit structures where possible.  They are much easier
to reead as they make the data layout explicit, including the holes
(as long as folk remember their c structure alignments!)
- no holes here obviously!

We only introduced the IIO_BUFFER macros to cover the cases we
can't represent as a structure because the timestamp moves
around as the number of channels enabled changes.  Necessary
trick to reduce the size of the kfifos.

Jonathan


