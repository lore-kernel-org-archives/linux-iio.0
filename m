Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3898F2F3C07;
	Sun, 31 May 2026 22:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780266883; cv=none; b=kogxvbu8LJwsMZVgDV+WeABnInOmsfTGLKwlDiHoQ0t+j62Xsr/JU/f4N4GJGYmmKL/CL1wajkkMeVNJRwLGpmufdInGuPpiQfddSG5woXN3x46q5aA/VnPQ2n6PUqD4222MwszitM550SnkqZce6WIn2m0CZAzlL5Hg4907iKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780266883; c=relaxed/simple;
	bh=1w/XmGImkKs963Ilz6vGbGb0LNWY+l1lMkvudt/d7tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ANgz8QkCf+6z+dVknjlZvhPCY7aZNhc0hULWeRz7XTIMaFpVhcsjzvSQREmsUK2IcYmlzeCvNfUzL5+iJGuX/Hnm9OqYFWumFIWnTQg1EBF5UjienHn9Pi/zpBFnDCu4TLZinr2HPrPeM4E/hbKV6e3wTWZBt7dVH3I/CzM8/vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cayf2QP4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cayf2QP4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C93E1F00893;
	Sun, 31 May 2026 22:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780266881;
	bh=SV45GBCvYe+hp8eMhlHRAxDNaLoFAabqkpzpMKAV6UM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cayf2QP45Jx3wZ9lI4tlOvslACrHlSvFdyfuvLkL9NWaULtZqrOSorMkPnQ6V9dOF
	 MXCDmpWk3zFUCOnQFPxe32Hfu6X+mozYWCoJDAX/C/G8rtTbbFB9UCt+KCKjAPGuOf
	 tu1rQdMIP2e8HaLvYlnxgujcJPVmHfs31LUkXas8wLFHQxHuSeLDvEFSgFYI4VqqGM
	 E+Gnj6QZFAWyzQLYsGqRZ7DcVV9/K39I2sk/4BRuUuH67T2C6u2QNln4FCUUuxH3zA
	 CiQAJUOTYNpW7gCLSSYugf+OXe46pt+ID1dQXZ9nJzFCWjbb9nrVpt/4oEwnfZpfkc
	 0o4B0BH/avnEw==
From: William Breathitt Gray <wbg@kernel.org>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	patrick.havelange@essensium.com,
	peng.fan@nxp.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andy@kernel.org
Subject: Re: [PATCH] counter: ftm-quaddec: use devm_mutex_init()
Date: Mon,  1 Jun 2026 07:34:35 +0900
Message-ID: <178026663949.725822.1015642435513872635.b4-ty@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260523184351.7567-1-sozdayvek@gmail.com>
References: <20260523184351.7567-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=558; i=wbg@kernel.org; h=from:subject:message-id; bh=/KG3HJL4UOcmUr3QSGJgt6wJqiJv0suB4duAKggEqbU=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDFky27YJ2ai0C9wJ3i5ldtiqfupRY8nTVSmfU93+Z6lc4 l7qLBXfUcrCIMbFICumyNJrfvbug0uqGj9ezN8GM4eVCWQIAxenAEyk3YXhfzar0bIyqcYa5X1P kjtXlweq1cxOlP2/X+ntJxHv2bJ6Pxl+s203+KUprTEl5tmH1X9r3vybb3wg9bPx3gUZTuffFy9 J5AYA
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit


On Sat, 23 May 2026 23:43:51 +0500, Stepan Ionichev wrote:
> ftm_quaddec_probe() calls mutex_init() but neither the cleanup
> action nor a remove callback issues a matching mutex_destroy(),
> so the lock debug state is leaked on driver unbind.
> 
> Switch to devm_mutex_init() so the mutex is torn down in the same
> devm scope it was set up in.
> 
> [...]

Applied, thanks!

[1/1] counter: ftm-quaddec: use devm_mutex_init()
      commit: b400c076fe4b63576fa22fbb59078b030000970c

Best regards,
-- 
William Breathitt Gray <wbg@kernel.org>
