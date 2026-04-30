Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0BA2DEA61
	for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 16:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777568118; cv=none; b=UdO2TvjQyMwLxixmczg7s4t5ssdEXC7ZLtECSeIbfYIqr90Or7z6FmvZSxzwB/XiCSvq6uf9u8eUhdvz2637CCGnT5n8PGhyFbPapDrEvYM0lNPxHahcvrxVT/h/SJ7wksDTJALnhWeIItVvPEFpzhHoqtl3UcwYFMvFwucDX4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777568118; c=relaxed/simple;
	bh=EuOlftwJxEFp+EQLo3S6cTi/UqlmZBGzMlLQUXlsg8U=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=I/51NNPx18W9kxos4YZElrteeh+Ii0pflZ6yRwpJK1I/lLvfwIuja6SozQzPDbvfzGCjCsr/StF+7TxAeEDllX66BsBmDPQrti9phU7sjaVuNybu/e6Lh0vJ520KFPLLiJov55VsXdErfmGiyBV2bg8QCQAgKxfwkM3rh/on2hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/6toOQb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/6toOQb"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7C3CC2BCB9
	for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 16:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777568117;
	bh=EuOlftwJxEFp+EQLo3S6cTi/UqlmZBGzMlLQUXlsg8U=;
	h=From:To:Subject:Date:From;
	b=Y/6toOQbyP3t/V8rMTQryt1zZphN/xOpWwO4SKbzcqaeKq3ORMyPExScvMnI5CPtR
	 b/5U1vj+n3GarW3syXMhUw18cGl6Rhub+YmSRhgrSWyque/+PR2+AIKSK2KWHbgbpK
	 8uGkyUnk/4XK0rCFgbzSu7NCnLCRH9LIfXDP9oe1l/bZsoAILYkD1OLplFO1sM3/XR
	 5aA4MatpMFeHCnGdaCiZCpmxMWsh+01FofNDLTIumGd3d8jdL+HFqNQ9fWBaZRi1oG
	 /+RRobtrSI1E/4lNJwi46jkyP+pUtBA6CV3rGMQ+Vlq4tmt0jzwi7mTw2hOdPwcik4
	 3I0AaoFdyY5KA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D66EDC3279F; Thu, 30 Apr 2026 16:55:17 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 221442] New: Compile time assert error on iio/opt4001:
 FIELD_PREP: value too large for the field
Date: Thu, 30 Apr 2026 16:55:17 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: lito.15@proton.me
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-221442-217253@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D221442

            Bug ID: 221442
           Summary: Compile time assert error on iio/opt4001: FIELD_PREP:
                    value too large for the field
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: IIO
          Assignee: drivers_iio@kernel-bugs.kernel.org
          Reporter: lito.15@proton.me
        Regression: No

When compiling one of the drivers (config was gotten with `zcat
/proc/config.gz` on Arch Linux), compilation fails with an assert:

```
drivers/iio/light/opt4001.c:215:9: error: call to '__compiletime_assert_528'
declared with 'error'
      attribute: FIELD_PREP: value too large for the field
  215 |         reg |=3D FIELD_PREP(OPT4001_CTRL_CONV_TIME_MASK, chip->int_=
time);
      |                ^
./include/linux/bitfield.h:138:3: note: expanded from macro 'FIELD_PREP'
  138 |                 __FIELD_PREP(_mask, _val, "FIELD_PREP: ");=20=20=20=
=20=20=20=20=20=20=20=20=20=20
\
      |                 ^
./include/linux/bitfield.h:91:3: note: expanded from macro '__FIELD_PREP'
   91 |                 __BF_FIELD_CHECK_MASK(mask, val, pfx);=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20
\
      |                 ^
./include/linux/bitfield.h:70:3: note: expanded from macro
'__BF_FIELD_CHECK_MASK'
   70 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?=20=20=
=20=20=20=20=20=20=20=20
\
      |                 ^
note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=3D0 =
to see
all)
././include/linux/compiler_types.h:694:2: note: expanded from macro
'_compiletime_assert'
  694 |         __compiletime_assert(condition, msg, prefix, suffix)
      |         ^
././include/linux/compiler_types.h:687:4: note: expanded from macro
'__compiletime_assert'
  687 |                         prefix ## suffix();=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
\
      |                         ^
<scratch space>:18:1: note: expanded from here
   18 | __compiletime_assert_528
      | ^
1 error generated.
make[5]: *** [scripts/Makefile.build:289: drivers/iio/light/opt4001.o] Erro=
r 1
make[4]: *** [scripts/Makefile.build:548: drivers/iio/light] Error 2
make[3]: *** [scripts/Makefile.build:548: drivers/iio] Error 2
make[2]: *** [scripts/Makefile.build:548: drivers] Error 2
make[1]: *** [/home/lito/linux-7.0.2/Makefile:2103: .] Error 2
make: *** [Makefile:248: __sub-make] Error 2
exit 2
```

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
