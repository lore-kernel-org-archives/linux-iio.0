Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD382ECD1D
	for <linux-iio@vger.kernel.org>; Wed,  1 Apr 2026 12:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775046466; cv=none; b=g9Tm18nLhjfR+rzOnRNHdP+2FgGdvLiqnigRq/mwtZIAxxV1N2qAXvpspTnseRlXGn6iujYL6ZF09lCzPTpp4Ceq+Kbx6HA1TSWKUY8XVXXw7XCCy+Skt0+TqxFphfqBeTIVXfgw7q2USvpSJVKusO/DU1iLHHK+9gx2T3QP1o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775046466; c=relaxed/simple;
	bh=Ok7B2jNwTqsXyRF89lzbmHwbAOZkAzb0KiLrVavzOZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JeIK77ZkN+/4y1pWUi2UmRNZA6O/WiYT+AActCEC+2Pff98Zjv6i9dns/HJSmIpOrUc4/fbdCBTLGCTl25TpQWVdN5/7FNrCEoRto5XV8OxfHb/dFYvMtzfHzZ2Q1EQePDMaq2SBjOqgIDDmMI464Qg4/aF+k1do7oOvMZupxNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9mO/af1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9mO/af1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 935E7C116C6;
	Wed,  1 Apr 2026 12:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775046466;
	bh=Ok7B2jNwTqsXyRF89lzbmHwbAOZkAzb0KiLrVavzOZ0=;
	h=From:To:Cc:Subject:Date:From;
	b=I9mO/af1cKFAW/ICdpSJEqdMWDxKscvz4T67XZhfOEKNJnrGWt3mDbjzd7NkRd/Wm
	 /K9zbOeUTKVHnwhmMktaSnJyl9nE/0Ssfa+YuoOnf4Smkc4FvqfNi/JFZcN6nKeZ0Z
	 p9zaoQF9EjLkOAYw+fKnuoAGriVfjM7Y7GdCSRKKjX8ff4PqO09jhl/YMoUkLrNArn
	 nLkvbuDXaYOuVh9Q+yR2V8OyNub+B+fNeNzXz8SdirzU2ki+avzIocNf8keMvnsdu5
	 H/H+/1LcrVqVFiie9cdOZF72OvZbsVH9Xi8ksn65sUvnXF7zisuLwsUZdRzdQuNhG8
	 42sRU7+LdyJOg==
From: William Breathitt Gray <wbg@kernel.org>
To: gregkh@linuxfoundation.org
Cc: William Breathitt Gray <wbg@kernel.org>,
	linux-iio@vger.kernel.org
Subject: [GIT PULL] Counter updates for 7.1
Date: Wed,  1 Apr 2026 21:27:39 +0900
Message-ID: <20260401122740.2018309-1-wbg@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=927; i=wbg@kernel.org; h=from:subject; bh=Ok7B2jNwTqsXyRF89lzbmHwbAOZkAzb0KiLrVavzOZ0=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDJln+YXPfqqb5PAwaoleePwJw0WZIVuKxA0OVRnL73lYl XxmB0tvRykLgxgXg6yYIkuv+dm7Dy6pavx4MX8bzBxWJpAhDFycAjARTQlGhn+LHk47nFzXPemt 2dW/qy6EeXzfPXnd4/+3E2LnbM85aLmZkeFSr9y0j5XbpBPnsqw+fM7hz+m3HCkxT4xzli2XXpl 59zI/AA==
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

The following changes since commit f338e77383789c0cae23ca3d48adcc5e9e137e3c:

  Linux 7.0-rc4 (2026-03-15 13:52:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-updates-for-7.1

for you to fetch changes up to cbf8db23fc58db8d516ebc7aa57c4563f36532b9:

  counter: sysfs: remove double return in counter_sysfs_attr_add() (2026-03-21 22:41:51 +0900)

----------------------------------------------------------------
Counter updates for 7.1

A cleanup patch for sysfs to remove a superfluous return statement in
counter_sysfs_attr_add() that was unintentionally left during an earlier
refactor.

----------------------------------------------------------------
Cosmin Tanislav (1):
      counter: sysfs: remove double return in counter_sysfs_attr_add()

 drivers/counter/counter-sysfs.c | 2 --
 1 file changed, 2 deletions(-)
