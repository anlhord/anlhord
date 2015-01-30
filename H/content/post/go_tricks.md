
// check ColumnWriter implements scan.Writer

var _ scan.Writer = (*ColumnWriter)(nil)
