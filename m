Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795547096;
	b=PqCLU4ub7Sadu/CEUG5i6UA33GK4O/B3IVOANP80C8ZSwbXgQc5k4ojYPejA563nahMn
	 X8wY+WUXS+1F76hq1zk31Qw+Rjn/BCj2OijKkvdM+xz8BxdMu0sMjolz+JqwFUwWCy5EM
	 sP7jAbHvJmFzsF6ruQLKSmMha3TSOKvKsSLVYdKSDzwKRsaOTu25FWnTl/hxqNteJf9Mt
	 bfPYTP1NpAAAqWSzsKQt3KmM/TldfdXX8BBYxyfSMiDEuXC7mZzld49Q3eM0fmwxMJmlu
	 e0AHmjsbdQXKrVogklN+AT5wS3bmhD3oI80exLBQTk1wb6GHY9h187Cax1ZciVBAJ1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795547096;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=Xc3mmrLjrHZi16TZiMxQ4MqsKvdShh/6Zel7neJrcco=;
	b=GbQIqRZ96ZLbTZ755fpF3wn4Z5Y3Qf6rgrO3mTYD9hXys5d7ws8ciTsRINgPtG5VTpSB
	 BTGBagdKHeswM10J+4ZtFkxLvVke+OVg+Dh8bVqkDkqBr0zF4Jt9e1Pw/ZjXlyzEYuJtI
	 dUQyny+zXdyHhJt9A1Cgwei/SqiM/mMu5gCPITB0AWC1DfbeNO7wzRPaGYuq5Bg/PE88G
	 enBOM9lHbT9z8fH5P92+PTc+7u9Ht7HXuQcQA9YF6WZ8A1a+8QNJpd3Ioe1ksJbzt+BvG
	 2nROL8OvfhD8rGJoKNGCPLw3nFo2Q0hlSmFxVMq0TKWWkIj60e0nYkYmWivIA5r7x7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KheLyZUc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD27606A321;
	Tue, 24 Nov 2026 19:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KheLyZUc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787C81F000C4;
	Tue, 24 Nov 2026 19:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795547095;
	bh=Xc3mmrLjrHZi16TZiMxQ4MqsKvdShh/6Zel7neJrcco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KheLyZUcMAm6n3dp+OY41OJ7qCsdiujlyqVVZMQSJ4J/4IyLLoNoIOaiKflFIkzka
	 J4UabCBNGjK0XywJh8UfBbovFubYUHLB9/5+yO06g0I04lkt/cqteyueKwgXXzcZRQ
	 567aK15BVHoDuc7slk+AD/BuEXiV5FGsUxMa88deuCVlBT5L80x2JrX+UNZGr3nhcC
	 jxi/RLPTcq1A4kKJRkVmrirbUYsOcNmwx77OonuV+289PCaH2mD6p+MFZICwVCGjQT
	 xvdmBOjTLqaJCF2yBPNxhCWGx/6pGB/HpEbhWAf/Gk8FjcsRxIZErmQB9o3WR6KMDw
	 H4jnfR6paXT/w==
From: William Breathitt Gray <wbg@kernel.org>
To: andriy.shevchenko@intel.com,
	David Lechner <david@lechnology.com>,
	phucduc.bui@gmail.com
Cc: William Breathitt Gray <wbg@kernel.org>,
	andy@kernel.org,
	dlechner@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com,
	sozdayvek@gmail.com,
	Maxwell Doose <maxwell@maxwelld.cc>
Subject: Re: (subset) [PATCH v4 0/2] counter: ti-eqep: Fix runtime PM leak and use devm_counter_add()
Date: Tue, 24 Nov 2026 14:04:42 -0500
Message-ID: <179554702689.2328455.2491613757922405436.b4-ty@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261109084342.51865-1-phucduc.bui@gmail.com>
References: <20261109084342.51865-1-phucduc.bui@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=451; i=wbg@kernel.org; h=from:subject:message-id; bh=r1gp2XKrrjxbhJ3S/6G94RPRtaEvUUZZxWKvWrRfA7o=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDNms93cULqsx+TqHYwFzltaxE6HS8sLPwt8Ex/6dUxjn2 rA+VepvRykLgxgXg6yYIkuv+dm7Dy6pavx4MX8bzBxWJpAhDFycAjCRjmZGhjMqud9/WW6osoyt 532n535x2pPVEy0l6oTLfrd+/btn2UtGhvkvrLe90lpsNnnpvQU/bv476x4fpbPh0f4zbhHuU/j +p3ADAA==
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit


On Mon, 09 Nov 2026 15:43:40 +0700, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> Hi,
> 
> This series picks up Stepan's v3 [1], which had no follow-up since
> May, with William's agreement [2].
> 
> [...]

Applied, thanks!

[1/2] counter: ti-eqep: Fix runtime PM leak on probe failure
      commit: 3978b72c1570b0bf60968a06b16659b3847b7793

Best regards,
-- 
William Breathitt Gray <wbg@kernel.org>
