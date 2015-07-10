Return-Path: <cristina.opriceana@gmail.com>
Date: Fri, 10 Jul 2015 13:50:54 +0300
From: Cristina Opriceana <cristina.opriceana@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel.baluta@intel.com, octavian.purdila@intel.com,
	julia.lawall@lip6.fr
Subject: [PATCH v2 0/4] tools: iio: Send error messages to stderr
Message-ID: <cover.1436524490.git.cristina.opriceana@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

This patchset indends to make some cleanup and send printf
error messages to stderr. The changes were performed with coccinelle for
failure messages and manual for other cases. The following script
was used:

@r@
expression e1, e2, stdout;
@@
(printf(e1);
|
printf(e1, e2);
|
fprintf(stdout, e1);
|
fprintf(stdout, e1, e2);
)
@script: python get_string@
e << r.e1;
tdres;
@@
if 'could not' in e.lower() or 'fail' in e.lower() \
or 'problem' in e.lower() or 'not set' in e.lower():
coccinelle.tdres = e
else:
cocci.include_match(False)
@r_match@
expression r.stdout, r.e1, r.e2;
identifier get_string.tdres;
@@
(
- printf(e1);
+ fprintf(stderr, tdres);
|
- printf(e1, e2);
+ fprintf(stderr, tdres, e2);
|
- fprintf(stdout, e1)
+ fprintf(stderr, tdres)
|
- fprintf(stdout, e1, e2)
+ fprintf(stderr, tdres, e2)
)

Changes in v2:
	- s/failiure/failure

Cristina Opriceana (4):
  tools: iio: Move printf failure messages to stderr
  tools: iio: Send usage error messages to stderr
  tools: iio: generic_buffer: Maintain fprintf() messages consistent
  iio: tools: iio_utils: Move general error messages to stderr

 tools/iio/generic_buffer.c    | 21 ++++++++++--------
 tools/iio/iio_event_monitor.c |  8 +++----
 tools/iio/iio_utils.c         | 51 +++++++++++++++++++++++++------------------
 tools/iio/lsiio.c             |  2 +-
 4 files changed, 47 insertions(+), 35 deletions(-)

-- 
1.9.1
