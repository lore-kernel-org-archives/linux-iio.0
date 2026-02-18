Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C19D345741;
	Wed, 18 Feb 2026 19:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771444630; cv=none; b=VuKklZuxmTXk5cNmNAfOdBK438PNJAdQJXKCPejoFjI3PA0Xd10MCJjCaPOWq13pJH+naW5cR/rR27JW1vBHtXEMo5IX+TGvdGCJ7HAK6caY1BgDkJ4BEDnTdPeMg26iwgjC0wbvdlZXNwgwMqZ9H6bDY4Uj0sIxbi7hKO46eWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771444630; c=relaxed/simple;
	bh=gat+rnnrUbK/Y6WytC8CslzBWIw44IxAUqnSKe3YTrY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RbZUhAVcZA6bX/0Q9gFSDztrWQRZ1xL4wluKxnNK8VRg++AX/BZoOEWC6n6Ikuo7nx4p+TIgZgB1nmA/iAuDK0BPdL1/ceFgfmd5wzaJ+DxUZA0tguXqO/ecb8mwpT64kd2eQMSu4xJmY2LG4ZY/i6btWuX1HiHpwJ7rGhpXXLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aU14TGs1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aU14TGs1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA95C19422;
	Wed, 18 Feb 2026 19:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771444630;
	bh=gat+rnnrUbK/Y6WytC8CslzBWIw44IxAUqnSKe3YTrY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aU14TGs1bcBdcieOvY4AjyQhrda6+MkmVlhMOuzrvau4aRL1lBtCrYeKF/2apBpWE
	 mtVLTp11y3++lF+DvWTLWjTb3rlyub4/6jOkIIVa5jeoZLNmR0DC96Ra7y7J1/lxuZ
	 2GVQh9+zp74dG9vcowhY3oIVqAYtnMacHVkIUgmCIYAltAz/P72ZBvohIaHePwfsqv
	 Yu/fx6ueqX3LNWeImBl2d5Z60hIyYgqacrdddRFOO+r45TjKGzXtYHZ9QeMOub1KOH
	 iDZxYI8pQ4LyAQeZ1R2jHqYJit4AjCi3njx2mjkvP8M/su6w101t1y/Y32+YMWQ0rs
	 qpK63qWL1ooJg==
Date: Wed, 18 Feb 2026 19:56:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@intel.com>, linux-arm-kernel@lists.infradead.org, Bjorn
 Andersson <andersson@kernel.org>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng
 <boqun@kernel.org>, Waiman Long <longman@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Mark Brown
 <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich
 <dakr@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Orson Zhai <orsonzhai@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>,
 Thomas Gleixner <tglx@kernel.org>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Lee Jones <lee@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Srinivas Kandagatla <srini@kernel.org>, Antonio Borneo
 <antonio.borneo@foss.st.com>, Linus Walleij <linusw@kernel.org>, Konrad
 Dybcio <konradybcio@kernel.org>, linux-remoteproc@vger.kernel.org,
 linux-doc@vger.kernel.org, driver-core@lists.linux.dev,
 linux-iio@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-spi@vger.kernel.org
Subject: Re: [RFC PATCH v2 13/13] hwspinlock: refactor consumer.h from
 public header
Message-ID: <20260218195651.6a3fe5e8@jic23-huawei>
In-Reply-To: <20260215225501.6365-14-wsa+renesas@sang-engineering.com>
References: <20260215225501.6365-1-wsa+renesas@sang-engineering.com>
	<20260215225501.6365-14-wsa+renesas@sang-engineering.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Feb 2026 23:54:53 +0100
Wolfram Sang <wsa+renesas@sang-engineering.com> wrote:

> Factor out the entries only needed for consumers from the generic public
> header. This allows for a clean separation between providers and
> consumers.
> 
> FIXME: separate driver changes?
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com>

for the IIO one.

Thanks,

Jonathan

