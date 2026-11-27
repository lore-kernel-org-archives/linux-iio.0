Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795794995;
	b=dI+384LzhYKzaTq/Y6pLj2k2RwrJKr/Gq7APPIfTMGOdOBgJYS72fq3w/m8fDmucR1n/
	 IXzVPDcrhnJbLDzQamN3IVwVkFGQA/RiAE/0rVfa1SRm7EDck9gqbv1TjlJ0PfZzFHgYb
	 EvbAfrWk9IEClEimMbFyq7+xr2JFzZ4enyl6qgVthq9IG3bAASFxK3V92ek2AuxsfpoQA
	 eAX+xR9LrskLoQMssAMIsQHw5GRdH0gkIBuK3XgWwa4P6KcBqlcwk5EJEacAhUDU90MzW
	 0XKGZsUvFXyscUdXCpKBdgoiM5Y2Rn71ALKR/1X5l9dhtWP4119n1UqXRSwGPtrEACQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795794995;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=bgPYvQwX30aBETA8Szv2QHx8XAxhK+odkaJHnQIHjY0=;
	b=aMgbA5lgmVLeFS77IhNKudEWv/Ypm9yUdc0O63CDg+w8MAhmPKjeNDU6ZJ8XBDe0nXOS
	 aG76xFIF6S2qZsXdm7zwA/BeHt9wJkJsxxSHijXtXTL28ZtJm2Gvi/45R4s1pEqpsI3+S
	 mSYAshCfYJUNySXLU87oVM1rGTAFeBKp5t3YhbXtxQorf5waxXlVtMgIDrALSuZEppBgV
	 Oo0tdjbEya01ooR8uJ0MIOmhlkooeM2Kt32f79l0VILoR+R0fqaY81+f0SrA4OL8d1stR
	 MYFh7cq+SC3RBnf1294/sff4+sML8JDe6iCNqx7+B/vV9FePIATwOx26LxXTKmjJ6ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i8x6lK82;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EAF606A31C
	for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 15:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i8x6lK82
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEDD01F00919;
	Fri, 27 Nov 2026 15:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795794994;
	bh=bgPYvQwX30aBETA8Szv2QHx8XAxhK+odkaJHnQIHjY0=;
	h=From:To:Cc:Subject:Date;
	b=i8x6lK826kDcD5OXea4DX5PKnAkM2jyayAgY9U32xjdIxVgMB+60CvILYu/p8pSVq
	 pkEuSJ9loBYJnr8iM+Lp3XKSu5YM2WPiak2kaxW1N4hXRV8bg1sBW6b2D0gWrjYqp+
	 YIx3y8qc7pJrAnRiPVMhSfgH91/pQX3yBPag21fLJHK/VPgOVoQ5h2x/iVFjBwuqn6
	 5rgdNerxvWj9SLGqUAZn1VhfhxfLyNJAmhcN3WGlqJ7jMD/fQXJvIwtr1ZQjuvpm60
	 dHqQFexj99E/FvHG5YClwQ1J7qcICoa8BpyxrxD5z8JI2zRy83om/qlsgaexyiFNdD
	 /gQh9iZDM/q/w==
From: William Breathitt Gray <wbg@kernel.org>
To: gregkh@linuxfoundation.org
Cc: William Breathitt Gray <wbg@kernel.org>,
	linux-iio@vger.kernel.org
Subject: [GIT PULL] Counter fixes for 7.4
Date: Fri, 27 Nov 2026 10:56:21 -0500
Message-ID: <20261127155623.298693-1-wbg@kernel.org>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1715; i=wbg@kernel.org; h=from:subject; bh=/ol+f8/1OOH28QD4nTOYykStnRPpGewGoOwnT0t6LMc=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDNmcyx+dDJx26uKMTcn5E1Y+kg7c+Mpt/abZZ+71XN3n6 vXy0er/ch2lLAxiXAyyYoosveZn7z64pKrx48X8bTBzWJlAhjBwcQrARNaeY2Q496be88V+j6bs VO7mz+8yfnt21UgJKjj9XWVTqzz1y2UJhv9ZCnp8IhcZj5qvd7ty5yt33juH9FcVDk6dT7PSJLm 6/nIDAA==
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

  Linux 7.4-rc1 (2026-11-01 13:26:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-fixes-for-7.4

for you to fetch changes up to 0fdd4e1bdaa9084785280ce233fd3ddab04ff9cc:

  tools/counter: Reject invalid watch fields before narrowing (2026-11-24 14:16:57 -0500)

----------------------------------------------------------------
Counter fixes for 7.4

counter:
  - add compat_ioctl callback to compat_ptr_ioctl to prevent failure for
    Counter watches set by 32-bit tasks on a 64-bit kernel
rz-mtu3-cnt:
  - cleanup runtime PM reference if device initialization fails during
    Count enable write operation
ti-eqep:
  - fix runtime PM reference leak on probe failure by leveraging devm_*
    for proper path unwinds
tools/counter:
  - report back invalid Counter watch fields rather than silently
    truncating values

----------------------------------------------------------------
Danish Khateeb (1):
      counter: Allow 32-bit tasks to use the character device

Li Youhong (1):
      counter: rz-mtu3-cnt: put runtime PM ref if counter init fails

Stepan Ionichev (1):
      counter: ti-eqep: Fix runtime PM leak on probe failure

Zhu Jun (1):
      tools/counter: Reject invalid watch fields before narrowing

 drivers/counter/counter-chrdev.c     |  1 +
 drivers/counter/rz-mtu3-cnt.c        |  9 ++++---
 drivers/counter/ti-eqep.c            | 28 +++++++++++++-------
 tools/counter/counter_watch_events.c | 51 +++++++++++++-----------------------
 4 files changed, 43 insertions(+), 46 deletions(-)
