Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BB737CD55
	for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 06:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778826007; cv=none; b=TfxqT8sJULWftRZJFL6ZJuax5XzkIQtO9M+iPx1RRN0LPGEjKu7BecFS4fa3cZTudd90I1m2x0U34rSF3ENnD8Qfpii5Nh45ThKFHmfZVnqX7NfAcw8fRstGiy8pBnC4R+6Jjg1X6d3EJKNf6IAiGkiA1TCzE7rKsKpyKWEN99A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778826007; c=relaxed/simple;
	bh=tZ7zGJmNtJHmlX1YrzK1dgT0JPGYQIHaPj/Jf6fQVIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PkKaGWB1ym9ZJrZ4eKG+IAOd/5SsngSCw7fMItWzLmqEH6gGIZlAn1xFjiQOm3Du7H7nb98bY7TXsEyw1277I7FxhySWnNnISrBxLHc8CiHCTwEUxpm5mm9Per3UFg57RAgAejUBNqfetEuywJAPH+ObFOPwq2aiYVzNktdSoQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+02yUuw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+02yUuw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85AB9C2BCB0;
	Fri, 15 May 2026 06:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778826006;
	bh=tZ7zGJmNtJHmlX1YrzK1dgT0JPGYQIHaPj/Jf6fQVIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T+02yUuwb+RufHgvKpr96qP7RxCnG/4v1CGqPtlGdRXcighKojbNKYn9dK4Kxe4gX
	 gV6DzOeNwI/H3rvzG8vPNeEQQ0Hu8hRhWalegnPE9GPfUdXEgmruEr4O93CV23jbJf
	 6zWgJApn1OVL2LhQtjCY20pYS4dWBhzjbNzFu58whEC5WppQ5LxITIF6jxBmLekLYi
	 ey6FQ39G8wS11dZfLVfdiQx6M70H3dbWgvDrytpT0ZjEz+QYp5NO2I0sPUgvvZ4r56
	 iUWgn17g6mumN9Mf4eGc8hB4mByU5yBnkcf7Hiew0poFp6orGYNAGHGJDQkQGSRB7n
	 ZK5x4He8v7NkQ==
From: William Breathitt Gray <wbg@kernel.org>
To: ilpo.jarvinen@linux.intel.com,
	Joao Paulo Menezes Linaris <jplinaris@usp.br>
Cc: William Breathitt Gray <wbg@kernel.org>,
	Guilherme Dias <guilhermeabreu200105@usp.br>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v3] counter: intel-qep: Replace manual mutex logic with lock guards
Date: Fri, 15 May 2026 15:20:01 +0900
Message-ID: <177882592263.340324.11974519291675351329.b4-ty@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173058.14858-1-jplinaris@usp.br>
References: <20260512173058.14858-1-jplinaris@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=536; i=wbg@kernel.org; h=from:subject:message-id; bh=v+3BVkRoPJtx7dLKa9eXXNE6Ii0u/b29gT7OlByO3sU=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDFlsu84p5u7052Zikwq8rnfkleIGm2zD8808SQobNnG4l z5U/srXUcrCIMbFICumyNJrfvbug0uqGj9ezN8GM4eVCWQIAxenAEzktTQjw7V9c3JPxe1cW3DW Xc4+VU5OxE5pwXLDNvVihe/aS1dsC2JkWDGp6YjsNvk29n6epw/klPx9mWZZitznbre5bfr17NO PLAA=
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit


On Tue, 12 May 2026 14:30:57 -0300, Joao Paulo Menezes Linaris wrote:
> Use guard() for handling mutex lock instead of locking and unlocking
> mutex explicitly. This improves readability by eliminating the need for
> gotos and by clearly indicating mutex will be locked only when
> execution is in guard scope.
> 
> 

Applied, thanks!

[1/1] counter: intel-qep: Replace manual mutex logic with lock guards
      commit: ee4133b921a17b239ca617e9b0c16cad1277e9fd

Best regards,
-- 
William Breathitt Gray <wbg@kernel.org>
