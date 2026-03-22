Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0DD2848AA;
	Sun, 22 Mar 2026 11:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774179219; cv=none; b=RCH5rnth8DZiGTDHKt+yHtHBSXKVrwbnFCYJM1lzluB8fGwD7ILREc6uQqfcRWWOmXHhCowzbNGsZB8thYltQvDSVDHiQZtmbudlUTh54dnrF4rRsRAma6TP15pzn9jlrs1VtMw5RllHvil8Lj+NG7ayh0jtq3+lVEgZvK2iOGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774179219; c=relaxed/simple;
	bh=Bccne5nPibsXJjVfsoiwRixeabEO/EhhjpYgKAcFl98=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hJVT8qnB5lnlPHKUfaMAr0Zm24MYbp29NRUGJfuK+6EmCciym4TdWtY13MtWVXp37QdoD9XFvkkjTKnQBXNRy6bu8JVfLPmIjMuxfjjJqbQdrrCFxBW76tVcQScJBxSlfiizs/jq84CG6Y8agYO8LC/rpNvduP6idI8TcuUA73U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kky4Zidk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kky4Zidk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F89FC19424;
	Sun, 22 Mar 2026 11:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774179219;
	bh=Bccne5nPibsXJjVfsoiwRixeabEO/EhhjpYgKAcFl98=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kky4ZidkO5RLwjYJMoFVg8ShSFgC4zNVnj5nmFOn3a549cVa0VNXqo5ycd7Y//GKG
	 IVvLeaK9VtsDK0UCzMfsdrBf6zvVcaEJ3Vz4nAhoRIaUXedWwiw0+inwRzKAGbwUNV
	 rGBK4XpfeeOl9vGxvpnNmZkkHQ4Li06ByyXF7MrwGExSykUyFRa9yHIns1H0KRa2N8
	 lD3ANldATeCogr5yvSIyAxWGsGzeyLp26kYok80Ktk9WC58WzFq9/2W0zv5H1AeSd+
	 +0OPGoLGYgTcn2AfIh6s7pWia8opil3ZtEX6GzPdqQFoaFsulfTOOgN1H8Qla6g+hb
	 rnqgzAiodORtA==
Date: Sun, 22 Mar 2026 11:33:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Morton
 <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, Steven Rostedt
 <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v9 0/9] ADF41513/ADF41510 PLL frequency synthesizers
Message-ID: <20260322113325.5d54df36@jic23-huawei>
In-Reply-To: <20260320-adf41513-iio-driver-v9-0-132f0d076374@analog.com>
References: <20260320-adf41513-iio-driver-v9-0-132f0d076374@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Mar 2026 16:27:25 +0000
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> This patch series adds support for the Analog Devices ADF41513 and ADF41510
> ultralow noise PLL frequency synthesizers. These devices are designed for
> implementing local oscillators (LOs) in high-frequency applications.
> The ADF41513 covers frequencies from 1 GHz to 26.5 GHz, while the ADF41510
> operates from 1 GHz to 10 GHz.
> 
> Key features supported by this driver:
> - Integer-N and fractional-N operation modes
> - High maximum PFD frequency (250 MHz integer-N, 125 MHz fractional-N)
> - 25-bit fixed modulus or 49-bit variable modulus fractional modes
> - Digital lock detect functionality
> - Phase resync capability for consistent output phase
> - Load Enable vs Reference signal syncronization
> 
> The series includes:
> 1. PLL driver implementation
> 2. Device tree bindings documentation
> 3. IIO ABI documentation
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
> Changes in v9:
> - Expose simple_strntoull() in a safer prototype instead of new kstrntoull()
I'm leaving this part to the experts.  Other than that aspect, I took
another look through the driver and all looks good to me.

Thanks,

Jonathan
