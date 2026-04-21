Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7102C282F02;
	Tue, 21 Apr 2026 15:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776784845; cv=none; b=pPVLfbJ1TRHpNTGvDCBT+kSaDUJGAmqTFFIA+QjOPmkGPZ2fw/6Ob08Mu3SJmxiL8kYTUjsIyBim1nWdHCX7BuHStaAz2U1HapZXwZk8zzLnG2/PMa7SoxHJjw7LsNFcs3+TCj7P0wI8CJHb3/COyaCRVBnd7XcW7d47ebCfzYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776784845; c=relaxed/simple;
	bh=Oojv/Zf/jOTzpC/eF1MOzg/4JnqXeq2GuvpTW96JO+s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MGAo9TIa/3V0rTpswur7xBx2af55C9h0QREhIbY21taon0HOsIyFRL6JUvhnllreEQzfiviKo3WHkP9iIVsJ0M/pYn2mh11RLNW+3MMhyBi6yYaULJVEfl13X+eT/KbRxCmqf3mb9yGhHrbMfr8W8+T1yJzU/uzVBpmlbxczYRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVkpPwDF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVkpPwDF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D17C2BCB7;
	Tue, 21 Apr 2026 15:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776784845;
	bh=Oojv/Zf/jOTzpC/eF1MOzg/4JnqXeq2GuvpTW96JO+s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KVkpPwDF0dttTAuQoFG85g0J3PkEmA78Oogk76M+lz6nNBUoxucXN3ok5+9ndyJm8
	 UXs+XMp38SjN/XwG6Yx/Io1WRMJiDdbimuGjMxKJQuI1Fp9cuJa+JqAT95r5YwHJfu
	 BFUdE6x7R9xb9+RGX/ch21AUogqGHxDjoUUBJz1QCMQ/76I+c+WIy6yeuWMO6wH1RN
	 BHWy9a6rHnurhMe75itUNhA+8fBHdzThPMOYg2X5UtvWfR/JbrskZIpAuaVhv2mzbC
	 gc9oV5cChwieSujt0Nj638oT9pBCk1COXWwfUfVZNWX/lPo22//txagzkcKywfJYsw
	 zhwWObu3Bdbdg==
Date: Tue, 21 Apr 2026 16:20:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, demonsingur@gmail.co,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] MAINTAINERS: Update maintainer for iio driver(s)
Message-ID: <20260421162037.1784abea@jic23-huawei>
In-Reply-To: <20260419173830.2802263-1-sanjayembedded@gmail.com>
References: <20260419122338.29911625@jic23-huawei>
	<20260419173830.2802263-1-sanjayembedded@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 19 Apr 2026 23:08:30 +0530
Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> The listed maintainer analog domain email for Cosmin Tanislav is no
> longer valid, and he would no longer maintain this driver(s).
> 
> Cosmin suggested adding Nuno from Analog Devices for further handling
> this driver(s). Add Nuno as maintainer.
> 
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
The v1 thread continued and ended up with suggestion to add a list
entry for linux@analog.com instead.

So I'll assume that will be what we have in v3.
