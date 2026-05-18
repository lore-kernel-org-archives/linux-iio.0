Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B1548165C;
	Mon, 18 May 2026 13:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779111155; cv=none; b=tULs9eKWxXPCutQXOMXBP4cWpY6IKzkQee5gSf+yptM/iklaNcoJkeN9ePI8I5llbPmxgpcD955qxtIQs6kSjoEZA++mLfGPzNuFLCP/3MwfOtNZWI2Toyd1zQEwQuxhvPgs3sEjnjtm+FOHJ7ga0lohRkmZfh/9bhWkJu3uKm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779111155; c=relaxed/simple;
	bh=GwjuOc0NW+yHcee7Gsk2fh1kqmbprDVj3oBETvA0a1M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nX3aAP6GbKVSK8So83ZCu352UrdyGiDCrvL8nLWfhNPprcyPUOO2WsefSsYch40HkIc3x3SOCArFCbvAyLR+Apn/ygMOyxOf5+yZcZYeV6rCmHppPSWFzVMoQ3AcmeoOJm3qJN7XICLuw9WQZLzdnAhajpeMyiP2nzvVMsuPWLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COBWUXgK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COBWUXgK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3250EC2BCB7;
	Mon, 18 May 2026 13:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779111155;
	bh=GwjuOc0NW+yHcee7Gsk2fh1kqmbprDVj3oBETvA0a1M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=COBWUXgKJXB8PHExmh7IhXKbI6W4RzAB4LBpuZNERnsylkxzUUe89EhWVqTY9Os/A
	 23rDmD1jGRJpj1cDlxSJT7q13mVc5gZJ0gt2Y3pYx85Vxv0zz4jLmkNPwBeYKQMSas
	 265qcfC9tc4ph/R0WOcaZvUmSEkEUapuCw9rBGMy54JPD9CB9DK+ZJk9TKhrbZfqHJ
	 9ipJaep4EGj/FC0Pb2+k9LtXP47sWUGJ2NgsUSrfvItxmKZ4532oygrohsNwwVBmOQ
	 u6+ob8pST1J3ggclwpsUItbnPqmrz+16l/XsjNuGtXwolZpH2PLFItkjnMIAO8hdXw
	 5XFo1xJwHLu0g==
Date: Mon, 18 May 2026 14:32:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 sakari.ailus@linux.intel.com, christoph.muellner@theobroma-systems.com,
 martink@posteo.de, mfuzzey@parkeon.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/10] iio: accel: mma8452: cleanup codestyle warning
Message-ID: <20260518143226.6b611415@jic23-huawei>
In-Reply-To: <20260505174640.3998281-4-sanjayembedded@gmail.com>
References: <20260505174640.3998281-1-sanjayembedded@gmail.com>
	<20260505174640.3998281-4-sanjayembedded@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  5 May 2026 23:16:33 +0530
Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> Reported by checkpatch:
> FILE: drivers/iio/accel/mma8452.c
> 
> CHECK: Alignment should match open parenthesis
> 
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Applied.
