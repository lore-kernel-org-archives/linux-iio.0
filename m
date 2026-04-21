Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A96230E84B;
	Tue, 21 Apr 2026 10:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776767923; cv=none; b=oD1YDxlcyxeiALFLgJo0yvs519MY3ep/KChlY0f78AN7x9ZYtXI0nZK7Na9MPyqjKcA1wvEJ6rQ0Bw13ndvX1MJXvLzJ4NIxhXj17ZefTP3oTJevj7JAy0dENE/qPFphTGwbSvdj+uq+KcW3ICNvsNt6GGThoLHPb0TOZFOcTyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776767923; c=relaxed/simple;
	bh=V/oQyNWPgL6EUFWDcZugiDgB44kb/Q6wvxwuEk2xlmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=chwHieHdfQHedv6XZPJirnemuJvVBLsvbZpahkYMUgs8Age8lK9fHhX+mqb+tfYhzF03PudBAH/K2ANg8g5IcGFra385Zc9xbLO+7U+9hW+w8OzvMWtKAVqRptTXKu6OXrDS1KWTJFA7iPRkIxhGMumLUd9VifLx9/ogzs5Zm3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l12UK4Hd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l12UK4Hd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB4EC2BCB0;
	Tue, 21 Apr 2026 10:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776767923;
	bh=V/oQyNWPgL6EUFWDcZugiDgB44kb/Q6wvxwuEk2xlmQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l12UK4HdZzxmS/iKGfMHeQaQIr7M2vIhvB2Yqdbfrstb2kXAgz0jJLiWbX3N5CITj
	 QsI3rE6n3PGfXydR+uMy63c6PQSh88DUyGagRw9VeP2fYsR8vkwtHPHJl9JT1fgZMY
	 jDqFlJxnVP+33vc4ZXlJR4zuM8rDEMqsWRmfinmt8oc4f8Q6h6GBnrQ66AX6Mk2DsK
	 oTCkCbZu30YiZygOYbKP9umFbrfUj89ISMBdA0bvYDZ3eVdPGRAV9z/5IlfumiEct3
	 ZMcMwrkoIjEHKf7JW+btfpNvlwtMo8rzUVbAPTgaxYHmMJOaf4w/XKlRhfbpFCLkkT
	 i4Ja0GJWbXt8Q==
Date: Tue, 21 Apr 2026 11:38:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] iio: magnetometer: ak8975: modernize polling
 loops with iopoll() macros
Message-ID: <20260421113837.782980aa@jic23-huawei>
In-Reply-To: <20260421100722.1296-5-joshua.crofts1@gmail.com>
References: <20260421100722.1296-1-joshua.crofts1@gmail.com>
	<20260421100722.1296-5-joshua.crofts1@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Apr 2026 10:07:22 +0000
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> The driver currently uses while loops and msleep() for polling during
> conversion waits.
> 
> Replace the custom polling loops with readx_poll_timeout() and
> read_poll_timeout() macros from <linux/iopoll.h>. This reduces
> boilerplate, standardizes timeout handling and improves overall code
> readability, keeping the original timing and error behaviour.
> 
> Assisted-by: Gemini:3.1-Pro
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
The rest of this series looks fine to me.

Jonathan
