Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCAB846A;
	Mon, 18 May 2026 13:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779111346; cv=none; b=GAnUf+ROERqCb6tWr80IiWd2sxdGtgMAXTEZSBdwmLKEseloNvl2cM75MWvt1riwkXXE9jwfAt5pECeam0FwqDbk0IwK3I+i3MqinWck7hrBfceEthSCdSr7u/D6ILkxNbnCwUmOha94JO04GuZv1dlSHPqocvCvozUIThyGAOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779111346; c=relaxed/simple;
	bh=tTD2KFO/LC+8r22pT9p/jQgHJ5BW7ZL44cGZKwPhHtg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z5Si03GXBbDBxHyjEtN1/yx0QD4fMGviuLTDhSuqEBTbMDJ+HfIyfCv/eScVPwm55QL6GajcyOnNuMyVlqhfuMRcUoFI8XIPJT64qguNK4DdbVnxMhXrPIjyu7SAQ/sN4LMnpn7P+jVAIK6YKl9Q9oC8CIOT5zPssFfpzC1YXSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGTXM6vA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGTXM6vA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449B2C2BCB7;
	Mon, 18 May 2026 13:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779111345;
	bh=tTD2KFO/LC+8r22pT9p/jQgHJ5BW7ZL44cGZKwPhHtg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VGTXM6vAhKotngObYNp/Q37oMPhJ0LSKaA4+OAp4jnBmvomOdWU/lBv3k68UpU2qn
	 ztXPO8moTJVFr7fTo5QSzEwuCvUUrEgDUo7FHp+I2IxCSblwZYaB9/17lMP0DRIY3j
	 dxGvWGNlmoYc1M/VKpKdgeLRLE28ZacK2V4GFeAx8FuE4EotmNlZFL7Mgq9Yow/yht
	 8/ON6gQ8wSZfuV2XL08W7xGUOtVgfhj7XhsjilcUToIXHzbo9VXnFkEMZaEMpe3UxZ
	 skQ2SCGeKATGSkfLn0Qdg4bEJ8HusCDsNtlnMZQS6HGwZp9QeqX8h1cq6RfOq36TeQ
	 SOeIsox++Ihag==
Date: Mon, 18 May 2026 14:35:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 sakari.ailus@linux.intel.com, christoph.muellner@theobroma-systems.com,
 martink@posteo.de, mfuzzey@parkeon.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 05/10] iio: accel: mma8452: Use dev_err_probe()
Message-ID: <20260518143536.3990f002@jic23-huawei>
In-Reply-To: <20260505174640.3998281-6-sanjayembedded@gmail.com>
References: <20260505174640.3998281-1-sanjayembedded@gmail.com>
	<20260505174640.3998281-6-sanjayembedded@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  5 May 2026 23:16:35 +0530
Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> dev_err_probe() makes error code handling simpler and handle
> deferred probe nicely (avoid spamming logs).
> 
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Applied.
