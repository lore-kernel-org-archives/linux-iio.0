Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E78B3AB480;
	Tue, 12 May 2026 14:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594601; cv=none; b=c3LNS2prR8aTchWH6FyMzEQ8zzLL4Cb0KBtlNXaYu0UpHmYu0HMoGUAzn/K6fpZpRGbSkzKOxGZQxFlh13QXmt+SQ/uATyzsj83oSd9kTHj1z5a4kC00ISISJWscwXs6lfbnx+CWXVELm5mWO4C788Gz4lncGq1B49B+xO/IOHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594601; c=relaxed/simple;
	bh=Z8jpdLgVGomrujv8b5NEciVps5m1hdBCRBU8Aj581EU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fPt8Ls/t+JIVHJrEAVPclRKOFgqDZtTZ4ekpMmmqFPrjFQ5RjlldMyMH9qoTVdg8UB/WsySS1dELUNxUkiz75E9FBS3R91pNXbiaXi3FSf8PbHbrJL4nBy4bQuR8SJiMtCXi3UC4aDqciGd75qNhjia5oNAXGixGAVxQMOon6nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWatjo9/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWatjo9/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F8CC2BCB0;
	Tue, 12 May 2026 14:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778594601;
	bh=Z8jpdLgVGomrujv8b5NEciVps5m1hdBCRBU8Aj581EU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BWatjo9/ifH6AM1I2bZnO6XeW4mPwGs0gp1eDINh4d/cBx4NlU7efXLp8bsOZSWTd
	 /Rxv95ysngGCalssk5TxEdAg856jqwNYD5+B7Tn8Zxl2oLUXdd6+0H8pdMtPYipBXA
	 JXZovVeiK022spCjIIZaCYKtfnPsxnyLNfSq0QNJayzeerdWKmGSP5oMYJ9qjYFe5T
	 rQ8HjASttuZNnfJk78kP2P8+iAl6jIazHnO1yqHexSfZRKjUko/yIDKGzQ6LztbrC0
	 8hmcqHbYhD9de0RoPg5viVfRqJhG1cOOcrRRMtIzBwHvDnIlQeCuzNyOrqouqGTH50
	 zbepsULdvAa0A==
Date: Tue, 12 May 2026 15:03:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: marcelo.schmitt@analog.com, nuno.sa@analog.com, dlechner@baylibre.com,
 andy@kernel.org, linux-iio@vger.kernel.org, lars@metafoo.de,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/2] MAINTAINERS: update ADI IIO entry and specific
 IIO maintainer
Message-ID: <20260512150311.6f4838ef@jic23-huawei>
In-Reply-To: <20260511171643.3173872-1-sanjayembedded@gmail.com>
References: <20260511171643.3173872-1-sanjayembedded@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 May 2026 22:46:41 +0530
Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> Hi all,
> 
> Following suggestion from Jonathan and ack from Nuno, prepare change
> to add linux@analog.com list to has always valid coverage for ADI IIO
> drivers and add Nuno as maintainer to oversight the same.
> 
> Additionally, following confirmation from Cosmin and Marcelo replacing maintainer in specific IIO drivers.

Applied. Thanks

