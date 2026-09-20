Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C177443C3B;
	Sun, 20 Sep 2026 18:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789929162; cv=none; b=TQK0IApHfFGh8QvIK1XI2XfvH6/aUnVpqF4LhTSDQLvvxJFcsViUm/SUefkejl1Br8rtt/1GFVM7Gz6sRYcHpo1yypSdXYzY95no9HflwiqabI7d5sRZa8JkC/05Lub113/A6GGVeqXSZ0DgUVKIwMPPTysmsuk83XPzdEcr74c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789929162; c=relaxed/simple;
	bh=kWP6cIti8fPnGhooNbkkHLC9ZgKpljajG6qW882UJU0=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=hbHyCSCUexKlPYEy+8we9Hs4Mt6TN170hW6rV60WkuqXPqxRQ/qwD4Smmwl3fSD39FZ/TvRMujHo4NdSQAq1zwkOLgZKcNNqACgWeQDem1I3dnS5M64uwZiTnr0dsMqjxchwRuEb2xCPQPfyIWkIVfslQNlEgdvm30ntg15gpjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FMd/3450; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMd/3450"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A551F0089B;
	Sun, 20 Sep 2026 18:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789929161;
	bh=tcS0jhxis9lA5Ihd81JkW4gVPNbMj2+GxnyZJI8Byag=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=FMd/3450lTSp18dQzrXdap1aGxe529yIqCW9k+Dl8RBUkyRUBruRSiauAfX+OomY5
	 zYE0qS6mfo5WaINd/zV/2KNE4HH333PwLjd4leACgZAXFtsPxZExhHrwEO2IQWvTXy
	 JbfHOoQD65LXOe2ce66S43qVCjBmjXwmupAG2SqWXp/+uelkYRPjKKbhT2q3ZlK6BX
	 1gRU9IM25DYN/PrD4X65Gr9C/GE3GfFWEQrRk4uonOOJRhZ2szXYS72M8gKGFn1r4/
	 pwylqpGpfTUhabywSiDqp1I4CzARky03M0wyxCJOLxj2tmg3OHXX+KqI/UXFZB3GNy
	 vr+aKH9/5S7yg==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 10/10] iio: pressure: dps310: check the lock
 markings with context analysis
From: Jonathan Cameron <jic23@kernel.org>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Bill Wendling <morbo@google.com>, 
 David Lechner <dlechner@baylibre.com>, Eddie James <eajames@linux.ibm.com>, 
 Joel Stanley <joel@jms.id.au>, Jonathan Cameron <jic23@kernel.org>, 
 Justin Stitt <justinstitt@google.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
In-Reply-To: <20260918122517.377565-11-zoone.rupert@gmail.com>
References: <20260918122517.377565-1-zoone.rupert@gmail.com>
 <20260918122517.377565-11-zoone.rupert@gmail.com>
Date: Sun, 20 Sep 2026 19:32:13 +0100
Message-Id: <178992913316.706584.342289527605369716.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=628;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=kWP6cIti8fPnGhooNbkkHLC9ZgKpljajG6qW882UJU0=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqsCbGxWGCwA0F3EyMbcVZknDq+WenfcrRFx90h
 etZfA+3kzyJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCarAmxhEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiPAxEAC59wKz1GGDQ6DwmDfRkeO6KSvx5tTL2Nib9UCry5ddgz/
 TAavUBlWeLdk7/+iHeQInz15RlbLq0M7UwEAw6TOrjFdavn++EfkrSWPSRogtYZbu8uGRjs7cKf
 alXDE7EWyOCvshVFDTYzTyz8q34bZU2NdX5GiKheTxUiCA9KDsIz6h98QFb+IVpHxtufy8rualf
 7rK3u9HqhyZR1D/GdSYLPjb5LlCG0FX8sstZhsGiKIM0FpV4H6Lr0orT/idjSpgY6Xk5Wq8ucVx
 oE2qBB4DUVfiS+AZ7LCnvSR2Oj//Rm+q1NCvlGFygc17GYLV0zjEQdyuHN9I8x3NGdJcYn4ORDC
 Q0RGd9wzjHnHu3NrRQdOdhvhE0oKHiZAq+udhu/bqbxqhw5t/dFAog7KMOwbmmrPrhhpxQepvsf
 l3BTEUvnUq20nhUwnYshqhFMyRABWxNSXTuTvRatSIHMkuKLmChuWMkHrcdAA1yfN5JtFfC3yVh
 rVQYDxDuqXSWVw9cAol5hbFFjLaIWEnmQ0MdkIQYusNMqofNGOcYL7wNAWrWhZLvjpOtdgjR+hg
 zD0XwuylX4AxxnE5e7pyrnisbAiw4G3iLZvnT9IaGTbdBjb39gr9utRLbP4BVUqeABE8eJK+3me
 dHWpt/b3+oQ+zwZHnSkLTxw6mbRyliNl9eGgGHA==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> __must_hold() markings added earlier in this series are only
> documentation unless the file opts in, so switch the analysis on for
> dps310.o.
> 
> Clean with clang 23.1.0 and CONFIG_WARN_CONTEXT_ANALYSIS=y. It does run:
> dropping the lock around dps310_fifo_drain() warns rather than going
> quietly.
> 
> Assisted-by: LLM
> Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
Longer term I'd like to spend the effort to get this to be useable
across much of IIO but baby steps.  Hence enabling it just here for
now is fine.

Thanks,

Jonathan

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
